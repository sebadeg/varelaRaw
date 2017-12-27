class ImportarController < ApplicationController
  
  def index
  end

  require 'dbf' 

  def grados
	if request.post?
	  archivo = params[:archivo]
	  nombre = archivo.original_filename
      extension = nombre.slice(nombre.rindex("."), nombre.length).downcase      
      if extension == ".dbf"
      	tabla = DBF::Table.new(archivo.path).find(:all)
      	@resultado = tabla.select { |w| w.graimpnue > 0 }
      else
      	@resultado = nil
      end
    end
  end
end
