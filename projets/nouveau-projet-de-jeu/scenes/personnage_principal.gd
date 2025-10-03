extends CharacterBody2D

# === CONSTANTES ===
const SPEED := 200.0
const JUMP_VELOCITY := -400.0

# === VARIABLES ===
var velocity: Vector2 = Vector2.ZERO

# === LIENS AUX NŒUDS ===
@onready var sprite_2d: Sprite2D = $Sprite2D

# === FONCTION PHYSIQUE PRINCIPALE ===
func _physics_process(delta: float) -> void:
	# Appliquer la gravité
	velocity.y += get_gravity() * delta

	# Saut
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Mouvement gauche/droite
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED
		sprite_2d.flip_h = direction < 0  # retourner le sprite si on va à gauche
	else:
		# Ralentissement fluide si aucune touche n'est pressée
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Appliquer le mouvement
	move_and_slide()
