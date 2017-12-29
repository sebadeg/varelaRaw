class ImportarController < ApplicationController
  
  $grados = nil
  $alumnos = nil
  $cuentas = nil
  $archs = nil

  def index
  end

  def bancos
    if request.post?
      $archs = Array.new(0);
      archivo = params[:archivos].each do |file|
        nombre = file.original_filename
        $archs.push({ name: nombre, ext: nombre.slice(nombre.rindex("."), nombre.length).downcase })
      end
    end
    redirect_to importar_index_path
  end



  require 'dbf' 

  def grados
	   if request.post?
	    archivo = params[:archivo]
	    nombre = archivo.original_filename
      extension = nombre.slice(nombre.rindex("."), nombre.length).downcase      
      if extension == ".dbf"
      	tabla = DBF::Table.new(archivo.path).find(:all)
      	$grados = tabla.select { |w| w.graimpnue > 0 }
      else
      	$grados = nil
      end
    end
    redirect_to importar_index_path
  end

  def alumnos
    if request.post?
      archivo = params[:archivo]
      nombre = archivo.original_filename
      extension = nombre.slice(nombre.rindex("."), nombre.length).downcase      
      if extension == ".dbf"
        tabla = DBF::Table.new(archivo.path).find(:all)
        $alumnos = tabla.select { |w| (w.alufecdrei != nil && w.alufecdrei >= Date.parse('2017-10-01')) || (w.alufecdes != nil && w.alufecdes >= Date.parse('2017-10-01')) }
      else
        $alumnos = nil
      end
    end
    redirect_to importar_index_path
  end

  def cuentas
    if request.post?
      archivo = params[:archivo]
      nombre = archivo.original_filename
      extension = nombre.slice(nombre.rindex("."), nombre.length).downcase      
      if extension == ".dbf"
        tabla = DBF::Table.new(archivo.path).find(:all)
        $cuentas = Array.new(0);
        $alumnos.each do |a|
          $cuentas.push{ tabla.select{ |w| (w["GR5NRO"]==a["GR5NRO"]) } }
        end
      else
        $cuentas = nil
      end
    end
    redirect_to importar_index_path
  end

end
