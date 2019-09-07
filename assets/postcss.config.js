module.exports = {
  plugins: [
    require('postcss-import'),
    require('postcss-preset-env', {
      features: {
        'nesting-rules': true,
      },
    }),
    require('tailwindcss'),
    require('autoprefixer'),
  ],
};
