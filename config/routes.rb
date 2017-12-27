Rails.application.routes.draw do
  get 'importar/index'
  post 'importar/grados'

  get 'caja/servicios'
  post 'caja/carga'
  get 'caja/resultado'


  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
