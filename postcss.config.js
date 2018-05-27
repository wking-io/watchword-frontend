module.exports = ({ options, env }) => {
  const isProd = env === 'production';
  console.log(options);
  return {
    plugins: [
      require('autoprefixer')(isProd ? options.autoprefixer : false),
      require('postcss-clean')(isProd ? options['postcss-clean'] : false),
    ],
  };
};
