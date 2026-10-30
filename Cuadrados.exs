defmodule Svg do
  def iniciar(nombre_archivo) do
    File.write!(
      nombre_archivo,
      """
      <svg xmlns="http://www.w3.org/2000/svg" width="600" height="600">
      """
    )
  end

  def dibujar_cuadrado(nombre_archivo, x, y, lado, color) do
    File.write!(
      nombre_archivo,
      """
      <rect x="#{x}" y="#{y}" width="#{lado}" height="#{lado}"
      fill="none" stroke="#{color}" stroke-width="2" />
      """,
      [:append]
    )
  end

  def cerrar(nombre_archivo) do
    File.write!(
      nombre_archivo,
      "</svg>",
      [:append]
    )
  end
end

defmodule Generador do
  def generar(_, _, _, 0, _, _), do: :ok

  def generar(x, y, lado, cantidad, reduccion, archivo) do
    colores = [
      "red",
      "blue",
      "green",
      "orange",
      "purple",
      "brown",
      "black"
    ]

    indice = rem(cantidad - 1, length(colores))
    color = Enum.at(colores, indice)

    Svg.dibujar_cuadrado(
      archivo,
      x,
      y,
      lado,
      color
    )

    nuevo_lado = lado - reduccion

    nuevo_x = x + div(reduccion, 2)
    nuevo_y = y + div(reduccion, 2)

    generar(
      nuevo_x,
      nuevo_y,
      nuevo_lado,
      cantidad - 1,
      reduccion,
      archivo
    )
  end
end

defmodule Main do
  def main do
    archivo = "cuadrados.svg"

    cantidad = 7
    lado_inicial = 500
    reduccion = 60

    Svg.iniciar(archivo)

    Generador.generar(
      50,
      50,
      lado_inicial,
      cantidad,
      reduccion,
      archivo
    )

    Svg.cerrar(archivo)

    IO.puts("SVG generado correctamente.")
  end
end

Main.main()
