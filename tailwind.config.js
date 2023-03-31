const colors = require('tailwindcss/colors')
const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './node_modules/flowbite/**/*.js'
  ],

  theme: {
    fontFamily: {
      sans: ['DM Sans', ...defaultTheme.fontFamily.sans],
      mono: ['IBM Plex Mono', ...defaultTheme.fontFamily.mono],
    },
    colors: {
      primary: {
        '50': '#fff9eb',
        '100': '#ffeec7',
        '200': '#ffda8a',
        '300': '#ffc766',
        '400': '#ff9e1f',
        '500': '#f97706',
        '600': '#de4f02',
        '700': '#b72f06',
        '800': '#92220c',
        '900': '#781b0d',
      },
      secondary: colors.violet,
      tertiary: colors.neutral,
      success: colors.green,
      danger: colors.red,
      info: colors.amber,
    }
  },

  plugins: [
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/forms'),
    require('@tailwindcss/line-clamp'),
    require('@tailwindcss/typography'),
    require('flowbite/plugin'),
  ]
}
