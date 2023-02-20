module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fill: {
        'github-green': '#1a7f37',
        'github-purple': '#8250e9'
      }
    }
  },
  plugins: [
    require('@tailwindcss/typography'),
  ]
}
