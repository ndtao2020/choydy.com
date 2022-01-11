<template>
  <footer class="bg-white iq-footer">
    <div class="container-fluid">
      <div class="row">
        <div class="col-lg-6">
          <ul class="list-inline mb-0">
            <li class="list-inline-item">
              <router-link to="/privacy-policy">Privacy Policy</router-link>
            </li>
            <li class="list-inline-item">
              <router-link to="/terms-and-conditions">Terms of Use</router-link>
            </li>
          </ul>
        </div>
        <div class="col-lg-6 text-right">Copyright {{ new Date().getFullYear() }} <a href="/">ChoyDy.com</a> All Rights Reserved.</div>
      </div>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'MainFooter'
}
</script>
