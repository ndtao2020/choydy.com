module.exports = {
  root: true,
  env: {
    node: true
  },
  extends: ['eslint:recommended', 'plugin:vue/essential', 'plugin:vue/recommended', 'plugin:vue/strongly-recommended', 'plugin:prettier/recommended'],
  rules: {
    'no-console': 'warn',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off',
    'security/detect-object-injection': 'off',
    'vue/require-default-prop': 'off',
    'prettier/prettier': ['error', require('./.prettierrc.js')]
  },
  parser: 'vue-eslint-parser',
  parserOptions: {
    parser: 'babel-eslint',
    sourceType: 'module'
  },
  globals: {
    importScripts: true
  }
}
