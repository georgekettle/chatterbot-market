// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AlertController from "./alert_controller"
application.register("alert", AlertController)

import ChatScrollController from "./chat_scroll_controller"
application.register("chat-scroll", ChatScrollController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ModalController from "./modal_controller"
application.register("modal", ModalController)

import RatingController from "./rating_controller"
application.register("rating", RatingController)

import ReadMoreController from "./read_more_controller"
application.register("read-more", ReadMoreController)

import ScrollToElementController from "./scroll_to_element_controller"
application.register("scroll-to-element", ScrollToElementController)
