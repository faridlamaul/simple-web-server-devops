package main

import (
  "github.com/gin-gonic/gin"
  "simplewebserver.com/m/models"
  "simplewebserver.com/m/controllers"
)

func main() {
  r := gin.Default()

  models.ConnectDatabase()

  r.GET("/", controllers.FindUsers)
  r.POST("/", controllers.AddUser)

  r.Run(":3000")
}