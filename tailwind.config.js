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
    },
    colors: {
      // primary: {
      //     '50': '#f1f2fe',
      //     '100': '#e1e6fe',
      //     '200': '#cad0fc',
      //     '300': '#a9b0f9',
      //     '400': '#8688f4',
      //     '500': '#766eed',
      //     '600': '#604ce1',
      //     '700': '#533fc6',
      //     '800': '#41339e',
      //     '900': '#38317d',
      // },
      primary: {
          '50': '#fff9eb',
          '100': '#ffefc6',
          '200': '#ffde88',
          '300': '#ffcf66',
          '400': '#ffaf20',
          '500': '#f98c07',
          '600': '#dd6602',
          '700': '#b74506',
          '800': '#94340c',
          '900': '#7a2c0d',
      },
      secondary: colors.amber,
      tertiary: colors.neutral,
      success: colors.green,
      danger: colors.red,
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
