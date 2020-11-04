module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def package_statuses
    [
      ['Цех оцилиндровки', 'cylindering_shop'],
      ['Промежуточный склад', 'intermediate_warehouse'],
      ['Сушка', 'drying'],
      ['Пропитка', 'impregnation'],
      ['Склад готовой продукции', 'finished_goods_warehouse'],
      ['Отгрузка', 'shipment']
    ]
  end

  def user_superadmin?
    current_user.role == 'superadmin'
  end
end
