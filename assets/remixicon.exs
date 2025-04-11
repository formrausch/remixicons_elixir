defmodule Remixicon do
  @moduledoc """
  Provides precompiled icons from [remixicon.com v<%= @vsn %>](https://remixicon.com).

  Remixicons are designed by [Jimmy Cheung](https://github.com/xiaochunjimmy)

  ## Usage

  Remix icons come in two styles – fill and line.

  The icon components include the style as a suffix to the function name:

  ```heex
  <Remixicon.github_line />
  <Remixicon.github_fill />
  ```

  You can also pass arbitrary HTML attributes to the components:

  ```heex
  <Remixicon.github_line class="w-2 h-2" />
  <Remixicon.github_fill class="w-2 h-2" />
  ```

  ## Remix Icon License Attribution

  Copyright 2018 Remix Design Studio

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
  """
  use Phoenix.Component

  defp svg(assigns) do
    ~H"<.svg_base {@rest}><%%= {:safe, @path} %></.svg_base>"
  end

  attr :rest, :global, default: %{ fill: "currentColor", "aria-hidden": "true", viewBox: "0 0 24 24"}
  slot :inner_block, required: true

  defp svg_base(assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" {@rest}>
      <%%= render_slot(@inner_block) %>
    </svg>
    """
  end

  defp call_icon_function(icon_name, assigns) do
    try do
      function_name =
        icon_name
        |> Mix.Tasks.Remixicon.Build.normalize_function_name()
        |> String.to_atom()

      apply(__MODULE__, function_name, [assigns])
    rescue
      _e in BadFunctionError ->
        raise ArgumentError, "The icon `#{icon_name}` does not exist."
    end
  end

  @doc """
  Renders an icon by its name.

  You may also pass arbitrary HTML attributes to be applied to the svg tag.

  ## Examples

  ```heex
  <Remixicon.icon name="github-line" />
  <Remixicon.icon name="github-fill" %> class="w-4 h-4" />
  ```
  """

  attr :name, :string, required: true, doc: "The name of the icon including the desired style as suffix (e.g. `-line` or `-fill`)."
  attr :rest, :global, doc: "The arbitrary HTML attributes for the svg container", include: ~w(fill stroke stroke-width)

  def icon(assigns) do
    ~H"""
    <%%= call_icon_function(@name, assigns |> Map.delete(:name)) %>
    """
  end

  <%= for icon <- @icons,
      {name, path} = icon,
      func = Mix.Tasks.Remixicon.Build.normalize_function_name(name) do %>

    @doc """
    Renders the `<%= name %>` icon.

    You may also pass arbitrary HTML attributes to be applied to the svg tag.

    ## Examples

    ```heex
    <Remixicon.<%= func %> />
    <Remixicon.<%= func %> class="w-4 h-4" />
    ```
    """
    attr :rest, :global, doc: "The arbitrary HTML attributes for the svg container", include: ~w(fill stroke stroke-width)

    def <%= func %>(assigns) do
      svg(assign(assigns, path: ~S|<%= path %>|))
    end
  <% end %>
end
