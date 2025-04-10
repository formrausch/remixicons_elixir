[![logo](https://raw.githubusercontent.com/Remix-Design/RemixIcon/master/.github/files/logo-github.svg)](https://remixicon.com)

This library provides optimized svgs for each Remix Icon packaged as a Phoenix Component.

Remix Icons are open-source neutral-style system symbols elaborately crafted for designers and developers.
All of the icons are free for both personal and commercial use.

Current Remix Icon Version: **4.6.0**.

## Installation

Add Remix Icon to your `mix.exs`:

```elixir
defp deps do
  [
    {:remixicon, "~> 0.1.1"}
  ]
end
```

After that, run `mix deps.get`.

## Usage

The components are provided by the `Remixicon` module. Each icon is a Phoenix Component you can use in your HEEx templates.

By default, the lined component is used, but the `fill`
attribute may be passed to select styling, for example:

```eex
<Remixicon.github />
<Remixicon.github line />
<Remixicon.github fill />
```

You can also pass arbitrary HTML attributes to the components, such as classes:

```eex
<Remixicon.github class="w-4 h-4" />
<Remixicon.github fill class="w-4 h-4" />
```

For a full list of icons see [remixicon.com](https://remixicon.com/).

## License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
