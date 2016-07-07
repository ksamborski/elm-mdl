module Demo.Slider exposing (..)

import Platform.Cmd exposing (Cmd, none)
import Html exposing (..)
import Html.Attributes as Html

import Material.Slider as Slider
import Material

import Demo.Page as Page
import Dict exposing (Dict)


-- MODEL


type alias Mdl =
  Material.Model


type alias Model =
  { mdl : Material.Model
  , value : Float
  , values : Dict Int Float
  }


model : Model
model =
  { mdl = Material.model
  , value = 0
  , values = Dict.empty
  }


-- ACTION, UPDATE

type Msg
  = Slider Int Float
  | Mdl Material.Msg


get : Int -> Dict Int Float -> Float
get key dict =
  Dict.get key dict |> Maybe.withDefault 0


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of

    Slider idx value ->
      let
        values = Dict.insert idx value model.values
      in
        ({ model | values = values }, Cmd.none)

    Mdl action' ->
      Material.update Mdl action' model


-- VIEW


view : Model -> Html Msg
view model  =
  [ Html.p
      [ Html.style [("width", "300px")]]
      [ Slider.render Mdl [0] model.mdl
          [ Slider.onChange (Slider 0)
          , Slider.value (get 0 model.values)
          ]
          []
      ]
  , Html.p
      [ Html.style [("width", "300px")]]
      [ Slider.render Mdl [1] model.mdl
          [ Slider.onChange (Slider 1)
          , Slider.value (get 1 model.values)
          ]
          []
      ]

  , Html.p
      [ Html.style [("width", "300px")]]
      [ Slider.render Mdl [2] model.mdl
          [ Slider.onChange (Slider 2)
          , Slider.value (get 2 model.values)
          , Slider.disabled
          ]
          []
      ]
  ]
  |> Page.body2 "Sliders" srcUrl intro references


intro : Html m
intro =
  Page.fromMDL "https://getmdl.io/components/index.html#sliders-section" """
> The Material Design Lite (MDL) slider component is an enhanced version of the
> new HTML5 `<input type="range">` element. A slider consists of a horizontal line
> upon which sits a small, movable disc (the thumb) and, typically, text that
> clearly communicates a value that will be set when the user moves it.
>
> Sliders are a fairly new feature in user interfaces, and allow users to choose a
> value from a predetermined range by moving the thumb through the range (lower
> values to the left, higher values to the right). Their design and use is an
> important factor in the overall user experience. See the slider component's
> [Material Design specifications](https://material.google.com/components/sliders.html) page for details.
>
> The enhanced slider component may be initially or programmatically disabled.
"""


srcUrl : String
srcUrl =
  "https://github.com/debois/elm-mdl/blob/master/demo/Demo/Slider.elm"


references : List (String, String)
references =
  [ Page.package "http://package.elm-lang.org/packages/debois/elm-mdl/latest/Material-Slider"
  , Page.mds "https://material.google.com/components/sliders.html"
  , Page.mdl "https://getmdl.io/components/index.html#sliders-section"
  ]
