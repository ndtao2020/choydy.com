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
    'vue/no-v-for-template-key': 'off',
    'prettier/prettier': ['error', require('./.prettierrc.js')]
  },
  parser: 'vue-eslint-parser',
  parserOptions: {
    parser: '@babel/eslint-parser',
    sourceType: 'module',
    ecmaVersion: 2018,
    ecmaFeatures: {
      globalReturn: false,
      impliedStrict: false,
      jsx: false
    }
  },
  globals: {
    importScripts: true
  }
}
