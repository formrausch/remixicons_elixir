defmodule Mix.Tasks.Remixicon.Build do
  # Builds a new lib/remixicon.ex with bundled icon set.
  @moduledoc false
  @shortdoc false
  use Mix.Task

  alias Mix.Tasks.Remixicon.Update, as: UpdateTask

  @template_file "assets/remixicon.exs"
  @target_file "lib/remixicon.ex"

  def run(_args) do
    vsn = UpdateTask.vsn()
    svgs_path = UpdateTask.svgs_path()
    icons_files = Path.wildcard(Path.join(svgs_path, "**/*.svg"))

    icons =
      Enum.group_by(icons_files, &function_name(&1), fn file ->
        for path <- file |> File.read!() |> String.split("\n"),
            path = String.trim(path),
            String.starts_with?(path, "<path"),
            do: path
      end)

    ordered_icons = icons |> Enum.sort()

    assigns = %{icons: ordered_icons, vsn: vsn}

    Mix.Generator.copy_template(@template_file, @target_file, assigns, force: true)
    Mix.Task.run("format")
  end

  defp function_name(file) do
    file
    |> Path.basename()
    |> Path.rootname()
    |> String.split("-")
    |> Enum.join("_")
  end

  def normalize_function_name(file) do
    name = function_name(file)
    if Regex.match?(~r/^[0-9]/, name), do: "i" <> name, else: name
  end
end
