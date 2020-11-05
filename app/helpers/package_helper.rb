module PackageHelper
  def package_statuses_ru
    {
      cylindering_shop: 'Цех оцилиндровки',
      intermediate_warehouse: 'Промежуточный склад',
      drying: 'Сушка',
      impregnation: 'Пропитка',
      finished_goods_warehouse: 'Склад готовой продукции',
      shipment: 'Отгрузка'
    }
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
end
