module.exports = {
  'env': {
    'browser': true,
    'es6': true,
  },
  'extends': 'eslint:recommended',
  'globals': {
    'Atomics': 'readonly',
    'SharedArrayBuffer': 'readonly'
  },
  'parserOptions': {
    'ecmaVersion': 2018,
    'sourceType': 'module'
  },
  plugins: [],
  extends: [
    'eslint:recommended',
    'standard',
  ],
  'rules': {
    'semi': ['error', 'always']
  },
  overrides: [
    // jest files
    {
      files: [
        '__tests__/**/*.test.js',
      ],
      env: {
        'jest/globals': true,
      },
      plugins: [
        'jest',
      ],
      extends: [
        'plugin:jest/recommended'
      ],
      globals: {
        'page': 'readonly',
      },
    },
    // node files
    {
      files: [
        '.eslintrc.js',
        'jest.config.js',
        'jest-puppeteer.config.js',
        'postcss.config.js',
        'styleline.config.js',
        'tailwind.config.js',
        'webpack.config.js',
      ],
      parserOptions: {
        sourceType: 'script',
      },
      env: {
        browser: false,
        node: true,
      },
      plugins: ['node'],
      rules: {},
    },
  ],
};
