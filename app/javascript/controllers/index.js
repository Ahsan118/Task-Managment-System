eagerLoadControllersFrom("controllers", application)
// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import FlashController from "./flash_controller"
// Eager load all Stimulus controllers
eagerLoadControllersFrom("controllers", application)

// Register the FlashController
application.register("flash", FlashController)
