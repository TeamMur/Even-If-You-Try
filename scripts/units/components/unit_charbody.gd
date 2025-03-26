extends CharacterBody3D
class_name UnitCharBody

#Семантический доступ к скорости владельца
var speed: int:
	get(): return owner.speed

#Семантический доступ к скорости прыжка владельца 
var jump_force: int:
	get(): return owner.jump_force

#Переключатель состояния активности
#со сбросом рассчетов при отключении
var is_active: bool = false:
	set(val):
		is_active = val
		if not val: dir = Vector2.ZERO
		set_physics_process(val)

func set_active(flag: bool) -> void: is_active = flag

#Движение
func _physics_process(delta: float) -> void:
	# gravity
	if not is_on_floor(): velocity += get_gravity() * delta
	movement(delta)
	
	#перенаправление любого движения корню
	if position:
		owner.global_position = global_position
		position = Vector3.ZERO

func jump() -> void:
	if is_on_floor(): velocity.y = jump_force

#Движение с учетом поворота тела
#и плавной остановкой
var dir: Vector2
func movement(_delta):
	var direction: Vector3 = (owner.transform.basis * Vector3(dir.x, 0, dir.y)).normalized()
	if direction: #движение
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else: #плавная остановка
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		
	move_and_slide()
