package models

import (
  "fmt"
  "os"
  "gorm.io/gorm"
  "gorm.io/driver/postgres"
)

var DB *gorm.DB

func ConnectDatabase() {
        user := os.Getenv("DB_USER")
        password := os.Getenv("DB_PASSWORD")
        dbHost := os.Getenv("DB_HOST")
        databaseName := os.Getenv("DB_NAME")
        dbPort := os.Getenv("DB_PORT")

        dsn := fmt.Sprintf("host=%s user=%s dbname=%s port=%d sslmode=disable password=%s", dbHost, user, databaseName, dbPort, password)
        db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
        if err != nil {
        		panic(err)
        }

        DB = db
        DB.AutoMigrate(&User{})
}