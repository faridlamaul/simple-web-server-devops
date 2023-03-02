package controllers

import (
    "net/http"
    "github.com/gin-gonic/gin"
    "simplewebserver.com/m/models"
)

// Get all users
func FindUsers(c *gin.Context) {
    var users []models.User
    models.DB.Find(&users)
    c.JSON(http.StatusOK, gin.H{
        "message": "Hello World",
        "data": users,
    })
}

// Add new users
func AddUser(c *gin.Context) {
    var user models.User
    c.BindJSON(&user)
    models.DB.Create(&user)
    c.JSON(http.StatusOK, gin.H{
        "message": "User added successfully",
        "data": user,
    })
}