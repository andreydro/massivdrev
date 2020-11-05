module OrderHelper
  def order_statuses_ru
    {
      active: 'Активный',
      archive: 'Архивный'
    }
  end

  def order_statuses
    [
      ['Активный', 'active'],
      ['Архивный', 'archive']
    ]
  end
end
