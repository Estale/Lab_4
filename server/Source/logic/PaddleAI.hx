package logic;
/* Логика доски соперника */
import visual.Paddle;
import visual.Ball;

class PaddleAI {

	/* Скорость доски */
	var paddleSpeed:Int = 4;
	var enemyPaddle:Paddle;
	var ball:Ball;

	public function new (enemyPaddle:Paddle, ball:Ball) {
		this.enemyPaddle = enemyPaddle;
		this.ball = ball;
	}

	/* Действие на каждый кадр */
	public function move () {
		/* Постепенно передвинем доску к шару */
		if(enemyPaddle.y < ball.y - 10){
			enemyPaddle.y += paddleSpeed;
		} else if(enemyPaddle.y > ball.y + 10){
			enemyPaddle.y -= paddleSpeed;
		}

		if(enemyPaddle.z < ball.z - 10){
			enemyPaddle.z += paddleSpeed;
		} else if(enemyPaddle.z > ball.z + 10){
			enemyPaddle.z -= paddleSpeed;
		}
	}
}