extends KinematicBody2D

export var vel = 100
var cont = 0
var perto_chave = false
var perto_porta = false
var tem_chave = false
onready var chave = get_parent().get_node("chave")
onready var porta = $"../porta2"

func _ready():
	pass

func _process(_delta):
	var dir = Vector2(0,0)
	
	if Input.is_action_pressed("up"):
		dir.y = -1
	if Input.is_action_pressed("down"):
		dir.y = 1
	if Input.is_action_pressed("left"):
		dir.x = -1
	if Input.is_action_pressed("right"):
		dir.x = 1
	
	move_and_slide(dir * vel)	
	
	#print(dir)

func _input(_event):
	if perto_chave and Input.is_key_pressed(KEY_X):
		chave.queue_free()
		tem_chave = true
	
	if perto_porta and tem_chave and Input.is_key_pressed(KEY_X):
		if cont == 0:
			cont += 1
			porta.queue_free()
			porta = $"../porta"
		elif cont == 1:
			cont += 1
			porta.queue_free()
			print("jogo finalizado!")

func _on_Area2D_body_entered(body):
	if body.name == "chave":
		perto_chave = true
	elif body.name == "porta" or body.name == "porta2":
		perto_porta = true
		
func _on_Area2D_body_exited(body):
	if body.name == "chave":
		perto_chave = false
	if body.name == "porta" or body.name == "porta2" :
		perto_porta = false
