class CajaController < ApplicationController
  
	$subir_archivo = "";

  def servicios
  end

  def resultado
  end

  require "simple-spreadsheet"

  def carga
    if request.post?
      archivo = params[:archivo];
      nombre = archivo.original_filename;
      extension = nombre.slice(nombre.rindex("."), nombre.length).downcase;
      $subir_archivo = ""
      if extension == ".xls"
        s = SimpleSpreadsheet::Workbook.read(archivo.path)
        s.selected_sheet = s.sheets.first
        s.first_row.upto(s.last_row) do |line|
          (1..9).each do |i| 
            $subir_archivo = $subir_archivo + s.cell(line, i).to_s
            $subir_archivo = $subir_archivo + ";"
          end
          $subir_archivo = $subir_archivo + "<BR>"
        end
      elsif extension == ".csv" || extension == ".txt"
        s = File.readlines(archivo.path).each do |line|
          $subir_archivo = $subir_archivo + line.to_s
          $subir_archivo = $subir_archivo + "<BR>"
        end
      else        
        $subir_archivo = "Extension incorrecta"

		    #resultado = true
        #path = File.join(directorio, nombre);
        #resultado = File.open(path, "wb") { |f| f.write(archivo.read) };
        #Verifica si el archivo se subió correctamente.
        #Redirige al controlador "archivos", a la acción "lista_archivos" y con la variable de tipo GET "subir_archivos" con el valor "ok" si se subió el archivo y "error" si no se pudo.
      end
    end
    redirect_to caja_resultado_path

  end
end
