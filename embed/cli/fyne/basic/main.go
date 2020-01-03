package main

import (
    "fmt"
    "fyne.io/fyne"
    "fyne.io/fyne/app"
    "fyne.io/fyne/layout"
    "fyne.io/fyne/widget"
)

func main() {
    app := app.New()

    window := app.NewWindow("Example")

    user := widget.NewEntry()
    user.SetPlaceHolder("Username")

    password := widget.NewPasswordEntry()
    password.SetPlaceHolder("Password")

    login := widget.NewButton("Login", func() {
        fmt.Println("You may now act as if you were logged in :)")
    })

    window.SetContent(fyne.NewContainerWithLayout(layout.NewGridLayout(1), user, password, login))

    window.ShowAndRun()
}