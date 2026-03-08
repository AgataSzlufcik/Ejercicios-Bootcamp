import random
import tkinter as tk

def launch_snake_break(board_size=18, cell_size=22, speed_ms=120):
    root = tk.Tk()
    root.title("☕ Mini Snake Break")
    root.resizable(False, False)

    width = board_size * cell_size
    height = board_size * cell_size

    canvas = tk.Canvas(root, width=width, height=height, bg="#1e1e1e", highlightthickness=0)
    canvas.pack()

    info = tk.Label(
        root,
        text="Controles: flechas o WASD | R reinicia | ESC cierra",
        font=("Segoe UI", 10),
    )
    info.pack(pady=(6, 8))

    snake = [(board_size // 2, board_size // 2)]
    direction = (1, 0)
    score = 0
    game_over = False

    def spawn_food():
        free = [
            (x, y)
            for x in range(board_size)
            for y in range(board_size)
            if (x, y) not in snake
        ]
        return random.choice(free) if free else None

    food = spawn_food()

    def draw():
        canvas.delete("all")

        for x in range(board_size):
            for y in range(board_size):
                canvas.create_rectangle(
                    x * cell_size,
                    y * cell_size,
                    (x + 1) * cell_size,
                    (y + 1) * cell_size,
                    outline="#2d2d2d",
                    fill="#1e1e1e",
                )

        for index, (x, y) in enumerate(snake):
            color = "#7CFC00" if index == 0 else "#32CD32"
            canvas.create_rectangle(
                x * cell_size,
                y * cell_size,
                (x + 1) * cell_size,
                (y + 1) * cell_size,
                outline="#1e1e1e",
                fill=color,
            )

        if food is not None:
            fx, fy = food
            canvas.create_oval(
                fx * cell_size + 3,
                fy * cell_size + 3,
                (fx + 1) * cell_size - 3,
                (fy + 1) * cell_size - 3,
                fill="#FFD700",
                outline="#FFD700",
            )

        canvas.create_text(
            8,
            8,
            anchor="nw",
            text=f"Score: {score}",
            fill="#FFFFFF",
            font=("Segoe UI", 11, "bold"),
        )

        if game_over:
            canvas.create_text(
                width // 2,
                height // 2,
                text="💥 Game Over\nPulsa R para reiniciar",
                fill="#FFFFFF",
                font=("Segoe UI", 16, "bold"),
                justify="center",
            )

    def set_direction(new_direction):
        nonlocal direction
        if game_over:
            return
        if new_direction[0] == -direction[0] and new_direction[1] == -direction[1]:
            return
        direction = new_direction

    def on_key(event):
        key = event.keysym.lower()
        if key in ("up", "w"):
            set_direction((0, -1))
        elif key in ("down", "s"):
            set_direction((0, 1))
        elif key in ("left", "a"):
            set_direction((-1, 0))
        elif key in ("right", "d"):
            set_direction((1, 0))
        elif key == "r":
            reset()
        elif key == "escape":
            root.destroy()

    def reset():
        nonlocal snake, direction, score, game_over, food
        snake = [(board_size // 2, board_size // 2)]
        direction = (1, 0)
        score = 0
        game_over = False
        food = spawn_food()
        draw()

    def tick():
        nonlocal snake, food, score, game_over

        if game_over:
            draw()
            root.after(speed_ms, tick)
            return

        head_x, head_y = snake[0]
        delta_x, delta_y = direction
        new_x, new_y = head_x + delta_x, head_y + delta_y

        hit_wall = new_x < 0 or new_y < 0 or new_x >= board_size or new_y >= board_size
        hit_body = (new_x, new_y) in snake
        if hit_wall or hit_body:
            game_over = True
            draw()
            root.after(speed_ms, tick)
            return

        snake.insert(0, (new_x, new_y))

        if food is not None and (new_x, new_y) == food:
            score += 1
            food = spawn_food()
            if food is None:
                game_over = True
        else:
            snake.pop()

        draw()
        root.after(speed_ms, tick)

    root.bind("<Key>", on_key)
    root.focus_force()
    draw()
    root.after(speed_ms, tick)
    root.mainloop() 
