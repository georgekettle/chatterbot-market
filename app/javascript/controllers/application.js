import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// Import and register external Stimulus controllers
import PasswordVisibility from 'stimulus-password-visibility'
application.register('password-visibility', PasswordVisibility)

export { application }

