<template>
  <div class="body">
    <div class="card">
      <img style="border-radius: 200px; height: 200px; width: 200px; background: #f8faf5; margin: 0 auto" src="@/assets/images/sad-emoji.png" />
      <h1>Thất bại</h1>
      <p>Việc xác minh đã thất bại</p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'VerifyFailed',
  mounted() {
    setTimeout(() => {
      this.$router.push('/')
    }, 5000)
  }
}
</script>

<style lang="scss" scoped>
.body {
  text-align: center;
  padding: 40px 0;
  background: #ebf0f5;
  height: 100vh;
  h1 {
    color: #b04b4b;
    font-family: 'Nunito Sans', 'Helvetica Neue', sans-serif;
    font-weight: 900;
    font-size: 40px;
    margin-bottom: 10px;
  }
  p {
    color: #404f5e;
    font-family: 'Nunito Sans', 'Helvetica Neue', sans-serif;
    font-size: 20px;
    margin: 0;
  }
  i {
    color: #9abc66;
    font-size: 100px;
    line-height: 200px;
    margin-left: -15px;
  }
  .card {
    background: white;
    padding: 60px;
    border-radius: 4px;
    box-shadow: 0 2px 3px #c8d0d8;
    display: inline-block;
    margin: 0 auto;
  }
}
</style>
