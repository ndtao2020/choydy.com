<template>
  <div class="auth-page">
    <div v-if="!logged" class="container">
      <h5 class="auth-logo">
        <i class="fa fa-circle text-primary"></i>
        <a href="/">
          <img src="@/assets/images/logo.png" alt="logo" />
        </a>
        <i class="fa fa-circle text-danger"></i>
      </h5>
      <div class="widget-auth mx-auto">
        <p class="widget-auth-info mb-3">Vui lòng nhập tên đăng nhập và mật khẩu</p>
        <form class="mt" @submit.prevent="login">
          <div v-if="errorMessage" class="alert alert-sm alert-danger">
            {{ errorMessage }}
          </div>
          <div class="form-group">
            <input v-model="username" class="form-control no-border" required type="text" name="username" placeholder="Tên đăng nhập" />
          </div>
          <div class="form-group">
            <input v-model="password" class="form-control no-border" required type="password" name="password" placeholder="Mật khẩu" />
          </div>
          <button type="submit" class="btn auth-btn mb-3 btn-inverse btn-sm">Đăng nhập</button>
          <p class="widget-auth-info">Hoặc đăng nhập bởi</p>
          <div class="social-buttons">
            <button type="button" class="btn social-button mb-2 btn-warning" @click="loginGoogleAuthProvider">
              <i class="social-icon social-google"></i>
              <p class="social-text">GOOGLE</p>
            </button>
            <button type="button" class="btn social-button mb-2 btn-primary" @click="loginFacebookAuthProvider">
              <i class="social-icon social-facebook"></i>
              <p class="social-text">FACEBOOK</p>
            </button>
          </div>
        </form>
        <!-- <p class="widget-auth-info">Bạn chưa có tài khoản? đăng ký ngay</p>
        <router-link class="d-block text-center" to="login">Tạo tài khoản</router-link> -->
      </div>
    </div>
    <footer class="auth-footer">2022 &copy; Meme hài hước - <a href="//oackoubs.com/4/4803949">ChoyDy.com</a></footer>
  </div>
</template>

<script>
import Nprogress from 'nprogress'
import { mapGetters, mapActions } from 'vuex'
import { submit, loginBySocialNetwork } from '@/api/auth/login'
import { getAuth, signInWithPopup, GoogleAuthProvider, FacebookAuthProvider } from '@firebase/auth'

export default {
  name: 'LoginPage',
  data() {
    return {
      username: '',
      password: '',
      google: 'GOOGLE',
      facebook: 'FACEBOOK',
      loading: false,
      errorMessage: null
    }
  },
  computed: {
    ...mapGetters('auth', ['logged'])
  },
  mounted() {
    if (this.logged) {
      this.$router.push('/')
      return
    }
  },
  methods: {
    ...mapActions('auth', ['setAuthentication']),
    redirectPage() {
      window.location = this.$route.query.redirect || '/'
    },
    updateAuthentication(access_token) {
      const [, payloadData] = access_token.split('.')
      this.setAuthentication(payloadData)
    },
    async login() {
      if (this.loading) {
        return
      }
      if (this.username.length < 5 || this.password.length < 8) {
        this.errorMessage = 'Thông tin đăng nhập quá ngắn'
        return
      }
      Nprogress.start()
      this.loading = true
      try {
        const data = await submit(this.username, this.password)
        if (data && data.access_token) {
          this.updateAuthentication(data.access_token)
        }
        // redirect
        this.redirectPage()
      } catch (error) {
        this.errorMessage = 'Đăng nhập thất bại !'
      } finally {
        this.loading = false
        Nprogress.done()
      }
    },
    async applyCredential(social, credential, user) {
      Nprogress.start()
      this.loading = true
      try {
        const data = await loginBySocialNetwork(social, credential, user)
        if (data && data.access_token) {
          this.updateAuthentication(data.access_token)
        }
        // redirect
        this.redirectPage()
      } catch (err) {
        this.errorMessage = 'Đăng nhập thất bại !'
        // eslint-disable-next-line no-console
        console.log(err)
      } finally {
        this.loading = false
        Nprogress.done()
      }
    },
    async loginGoogleAuthProvider() {
      if (this.loading) {
        return
      }
      Nprogress.start()
      this.loading = true
      try {
        // check provider
        const result = await signInWithPopup(getAuth(), new GoogleAuthProvider())
        if (result) {
          await this.applyCredential(this.google, GoogleAuthProvider.credentialFromResult(result), result.user)
        }
      } catch (error) {
        // Handle Errors here.
        if (error.code === 'auth/account-exists-with-different-credential') {
          await this.applyCredential(this.google, GoogleAuthProvider.credentialFromError(error))
        } else {
          this.errorMessage = 'Đăng nhập thất bại !'
        }
      } finally {
        this.loading = false
        Nprogress.done()
      }
    },
    async loginFacebookAuthProvider() {
      if (this.loading) {
        return
      }
      Nprogress.start()
      this.loading = true
      try {
        // check provider
        const result = await signInWithPopup(getAuth(), new FacebookAuthProvider())
        if (result) {
          await this.applyCredential(this.facebook, FacebookAuthProvider.credentialFromResult(result), result.user)
        }
      } catch (error) {
        // Handle Errors here.
        if (error.code === 'auth/account-exists-with-different-credential') {
          await this.applyCredential(this.facebook, FacebookAuthProvider.credentialFromError(error))
        } else {
          this.errorMessage = 'Đăng nhập thất bại !'
        }
      } finally {
        this.loading = false
        Nprogress.done()
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import '~bootstrap/scss/functions';
@import '~bootstrap/scss/variables';
@import '~bootstrap/scss/mixins';
@import '~bootstrap/scss/root';
@import '~bootstrap/scss/reboot';
@import '~bootstrap/scss/type';
@import '~bootstrap/scss/forms';
@import '~bootstrap/scss/buttons';
@import '~bootstrap/scss/alert';
@import '~bootstrap/scss/utilities';

.auth-page {
  padding-top: 10vh;
  height: 100vh;
}
.widget-auth {
  max-width: 360px;
  padding: 30px !important;
  .widget-auth-info {
    font-size: 13px;
    color: #888;
    margin-bottom: 0;
    text-align: center;
  }
  .auth-btn {
    width: 100%;
    color: #fff;
    background-color: #0d2b47;
    border-color: #0d2b47;
    -webkit-box-shadow: inset 0 1px 0 hsl(0deg 0% 100% / 15%), 0 1px 1px rgb(0 0 0 / 8%);
    box-shadow: inset 0 1px 0 hsl(0deg 0% 100% / 15%), 0 1px 1px rgb(0 0 0 / 8%);
  }
  .social-buttons {
    display: flex;
    align-items: stretch;
    justify-content: center;
    flex-direction: column;
    margin: 1rem 0;
    .social-button {
      display: flex;
      align-items: center;
      padding: 0;
      position: relative;
      height: 30px;
    }
    .social-icon {
      position: absolute;
      left: 1px;
      width: 26px;
      height: 26px;
      padding: 0;
      transition: all 0.2s ease-in-out;
      border-radius: 3px;
      background-color: #fff;
    }
    .social-text {
      margin: 0 auto;
      font-size: 0.875rem;
    }
    .social-google {
      background-size: 100%;
      background-image: url('data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48c3ZnIHdpZHRoPSIzOHB4IiBoZWlnaHQ9IjM4cHgiIHZpZXdCb3g9IjAgMCAzOCAzOCIgdmVyc2lvbj0iMS4xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIj4gICAgICAgIDx0aXRsZT5BcnRib2FyZDwvdGl0bGU+ICAgIDxkZXNjPkNyZWF0ZWQgd2l0aCBTa2V0Y2guPC9kZXNjPiAgICA8ZyBpZD0iQXJ0Ym9hcmQiIHN0cm9rZT0ibm9uZSIgc3Ryb2tlLXdpZHRoPSIxIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPiAgICAgICAgPGcgaWQ9ImJ0bl9nb29nbGVfZGFya19ub3JtYWxfaW9zIj4gICAgICAgICAgICA8ZyBpZD0iYnV0dG9uLWJnLWNvcHkiPiAgICAgICAgICAgICAgICA8cmVjdCBpZD0icGF0aC0zIiB4PSIwIiB5PSIwIiB3aWR0aD0iMzgiIGhlaWdodD0iMzgiIHJ4PSIxIj48L3JlY3Q+ICAgICAgICAgICAgPC9nPiAgICAgICAgICAgIDxnIGlkPSJsb2dvX2dvb2dsZWdfNDhkcCIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMTAuMDAwMDAwLCAxMC4wMDAwMDApIj4gICAgICAgICAgICAgICAgPHBhdGggZD0iTTE3LjY0LDkuMjA0NTQ1NDUgQzE3LjY0LDguNTY2MzYzNjQgMTcuNTgyNzI3Myw3Ljk1MjcyNzI3IDE3LjQ3NjM2MzYsNy4zNjM2MzYzNiBMOSw3LjM2MzYzNjM2IEw5LDEwLjg0NSBMMTMuODQzNjM2NCwxMC44NDUgQzEzLjYzNSwxMS45NyAxMy4wMDA5MDkxLDEyLjkyMzE4MTggMTIuMDQ3NzI3MywxMy41NjEzNjM2IEwxMi4wNDc3MjczLDE1LjgxOTU0NTUgTDE0Ljk1NjM2MzYsMTUuODE5NTQ1NSBDMTYuNjU4MTgxOCwxNC4yNTI3MjczIDE3LjY0LDExLjk0NTQ1NDUgMTcuNjQsOS4yMDQ1NDU0NSBaIiBpZD0iU2hhcGUiIGZpbGw9IiM0Mjg1RjQiPjwvcGF0aD4gICAgICAgICAgICAgICAgPHBhdGggZD0iTTksMTggQzExLjQzLDE4IDEzLjQ2NzI3MjcsMTcuMTk0MDkwOSAxNC45NTYzNjM2LDE1LjgxOTU0NTUgTDEyLjA0NzcyNzMsMTMuNTYxMzYzNiBDMTEuMjQxODE4MiwxNC4xMDEzNjM2IDEwLjIxMDkwOTEsMTQuNDIwNDU0NSA5LDE0LjQyMDQ1NDUgQzYuNjU1OTA5MDksMTQuNDIwNDU0NSA0LjY3MTgxODE4LDEyLjgzNzI3MjcgMy45NjQwOTA5MSwxMC43MSBMMC45NTcyNzI3MjcsMTAuNzEgTDAuOTU3MjcyNzI3LDEzLjA0MTgxODIgQzIuNDM4MTgxODIsMTUuOTgzMTgxOCA1LjQ4MTgxODE4LDE4IDksMTggWiIgaWQ9IlNoYXBlIiBmaWxsPSIjMzRBODUzIj48L3BhdGg+ICAgICAgICAgICAgICAgIDxwYXRoIGQ9Ik0zLjk2NDA5MDkxLDEwLjcxIEMzLjc4NDA5MDkxLDEwLjE3IDMuNjgxODE4MTgsOS41OTMxODE4MiAzLjY4MTgxODE4LDkgQzMuNjgxODE4MTgsOC40MDY4MTgxOCAzLjc4NDA5MDkxLDcuODMgMy45NjQwOTA5MSw3LjI5IEwzLjk2NDA5MDkxLDQuOTU4MTgxODIgTDAuOTU3MjcyNzI3LDQuOTU4MTgxODIgQzAuMzQ3NzI3MjczLDYuMTczMTgxODIgMCw3LjU0NzcyNzI3IDAsOSBDMCwxMC40NTIyNzI3IDAuMzQ3NzI3MjczLDExLjgyNjgxODIgMC45NTcyNzI3MjcsMTMuMDQxODE4MiBMMy45NjQwOTA5MSwxMC43MSBaIiBpZD0iU2hhcGUiIGZpbGw9IiNGQkJDMDUiPjwvcGF0aD4gICAgICAgICAgICAgICAgPHBhdGggZD0iTTksMy41Nzk1NDU0NSBDMTAuMzIxMzYzNiwzLjU3OTU0NTQ1IDExLjUwNzcyNzMsNC4wMzM2MzYzNiAxMi40NDA0NTQ1LDQuOTI1NDU0NTUgTDE1LjAyMTgxODIsMi4zNDQwOTA5MSBDMTMuNDYzMTgxOCwwLjg5MTgxODE4MiAxMS40MjU5MDkxLDAgOSwwIEM1LjQ4MTgxODE4LDAgMi40MzgxODE4MiwyLjAxNjgxODE4IDAuOTU3MjcyNzI3LDQuOTU4MTgxODIgTDMuOTY0MDkwOTEsNy4yOSBDNC42NzE4MTgxOCw1LjE2MjcyNzI3IDYuNjU1OTA5MDksMy41Nzk1NDU0NSA5LDMuNTc5NTQ1NDUgWiIgaWQ9IlNoYXBlIiBmaWxsPSIjRUE0MzM1Ij48L3BhdGg+ICAgICAgICAgICAgICAgIDxwb2x5Z29uIGlkPSJTaGFwZSIgcG9pbnRzPSIwIDAgMTggMCAxOCAxOCAwIDE4Ij48L3BvbHlnb24+ICAgICAgICAgICAgPC9nPiAgICAgICAgPC9nPiAgICA8L2c+PC9zdmc+');
    }
    .social-facebook {
      background-size: 100%;
      background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAgZJREFUaEPtmrFPE1Ecx7/fa2pTlcFRlMEozCYstk2EjcTFybSwKIW2gwu4dMXVxHY1bQPoIG38DwwhjbGFAWEjISR06MYgDAaQpvczjemF1trW1rvekdfx9b37fT+/7/e9u0uOcPiPDtcPA+BxaHlE1+B2AtDZzUr5WypWqWk1APyh9D6AMScAaJrr/teP4UMFMCi3lAOD6ny9rnJAOdBnB1SEum2giJyD3AVwpBEX9XUi8hTgtW6v0zzPdAcEUgX42lO9SOY/vfzRLMAXTH8nccu2ACDjxbX5N38TaGsAETnxeN2386uz584EgHzezEanGsQvLWmP9u76SAz/HtdXSN6wZYRIfCisRZ5fFhcIZRYFkuhVsLWbWJAp5iKRy0X905m3EHnlWIBAMJ0UYsHeAGRcdJQ0slTIzm03ODCTeihVbbQ+Rsp7AN5egUy5D+iij2/lYjudRPmeJbx0DZ12mtfu/wEDZB7QJQfOBZhOTVCYtx0AiXUAxxDZKGSj7xr2QCj1guST2pgI7gDw2w7AENTiGHXGKWQ8av55H1AATXkz5RRSEfqHXa0caNssdQp1zpKKkIpQ55S0nWFqhAT4CUHj4zJxnYCnT93GclMB/pdIy98HrBBer6EcsLLbrWopB5QDfXbgykZoXUS/12dzLFnupnvySzZcrhW7Oh97WNI6E4r8AjWjpkBDWaVNAAAAAElFTkSuQmCC');
    }
  }
}
.auth-footer {
  margin-bottom: 25px;
  font-size: 13px;
  color: #636c72;
  text-align: center;
  @media (min-height: 600px) {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
  }
}
.auth-logo {
  margin-top: 15px;
  margin-bottom: 40px;
  text-align: center;
  i {
    font-size: 13px;
    margin: 0 20px;
  }
}
</style>
