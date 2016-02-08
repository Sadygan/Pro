class Status < ActiveRecord::Base
	belongs_to :project

	# validates :description, presence: true, length: { minimum: 15 }
	# Массив статусов 
	def array_status
		status = ["Обрабатываеться", "Отправлен", "Корректируется", "Выполнен"]
	end
	
	# Возврощает следующий статус при добовлении в базу записи таблици Status
	def change(status)
		
		i = array_status.index(status)
		
		last = array_status.last 
		last_index = array_status.index(last)

		if i == last_index
			array_status.last	
		else
			array_status[i+1]
		end
	end
end
