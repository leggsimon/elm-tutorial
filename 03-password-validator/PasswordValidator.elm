module Main exposing (..)

import Html exposing (Html, Attribute, div, input, text)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String exposing (any, length)
import Char exposing (isDigit, isLower, isUpper)


main =
    App.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


model : Model
model =
    Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ type' "text", placeholder "Name", onInput Name ] []
        , input [ type' "password", placeholder "Password", onInput Password ] []
        , input [ type' "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
        , viewValidation model
        ]


viewValidation : Model -> Html msg
viewValidation model =
    let
        ( color, message ) =
            if (not (isValidPassword model.password)) then
                ( "red"
                , "Password must be greater than 8 characters using at least one uppercase letter, one lowercase letter and one numeric digit"
                )
            else if model.password /= model.passwordAgain then
                ( "red", "Passwords do not match!" )
            else
                ( "green", "OK" )
    in
        div [ style [ ( "color", color ) ] ] [ text message ]


isValidPassword : String -> Bool
isValidPassword password =
    (any isDigit password)
        && (any isUpper password)
        && (any isLower password)
        && ((length password) > 8)
