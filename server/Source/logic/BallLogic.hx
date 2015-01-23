package logic;
/* Логика шара */
import visual.Paddle;
import visual.Ball;

class BallLogic {

	/* Скорость шара */
	var ballSpeedX:Float = -3;
	var ballSpeedY:Float = -2;
	var ballSpeedZ:Float = 2;
	var ball:Ball;
	var enemyPaddle:Paddle;
	var playerPaddle:Paddle;

	public function new (enemyPaddle:Paddle, ball:Ball, playerPaddle:Paddle) {
		this.playerPaddle = playerPaddle;
		this.enemyPaddle = enemyPaddle;
		this.ball = ball;
	}

	/* Действие на каждый кадр */
	public function move () {

		/* Проверим шар на столкновения с досками */
		if( playerPaddle.hitTestObject(ball) == true ){
		if(ballSpeedX < 0){
			ballSpeedX *= -1;
			ballSpeedY = recalculateSpeed(playerPaddle.y, ball.y);
			ballSpeedZ = recalculateSpeed(playerPaddle.z, ball.z);
		}

		} else if(enemyPaddle.hitTestObject(ball) == true ){
			if(ballSpeedX > 0){
				ballSpeedX *= -1;
				ballSpeedY = recalculateSpeed(enemyPaddle.y, ball.y);
				ballSpeedZ = recalculateSpeed(playerPaddle.z, ball.z);
			}
		}

		/* Подвинем шар на текущем кадре */
		ball.x += ballSpeedX;
		ball.y += ballSpeedY;
		ball.z += ballSpeedZ;

		/* Отразим шар от дальней и ближней стенок */
		/* И увеличим число очков победителю */
		if(ball.x <= ball.width/2){
			ball.x = ball.width/2;
			ballSpeedX *= -1;
			Main.playerLives--;
		} else if(ball.x >= Main.SCREEN_W-ball.width/2){
			ball.x = Main.SCREEN_W-ball.width/2;
			ballSpeedX *= -1;
			Main.playerScore++;
		}

		/* Отразим шар от верхнего и нижнего краев экрана */
		if(ball.y <= ball.height/2){
			ball.y = ball.height/2;
			ballSpeedY *= -1;

		} else if(ball.y >= Main.SCREEN_H-ball.height/2){
			ball.y = Main.SCREEN_H-ball.height/2;
			ballSpeedY *= -1;
		}

		/* Отразим шар от левого и правого краев экрана */
		if(ball.z <= ball.height/2){
			ball.z = ball.height/2;
			ballSpeedZ *= -1;

		} else if(ball.z >= Main.SCREEN_H-ball.height/2){
			ball.z = Main.SCREEN_H-ball.height/2;
			ballSpeedZ *= -1;
		}
	}

	/* Рассчет нового угла направления после соударения с доской */
	function recalculateSpeed(paddleY:Float, ballY:Float)
	{
		var ySpeed = 5 * ( (ballY-paddleY) / 25 );
		// ограничим скорость
		return Math.max(Math.min(ySpeed, 5), -5);
	}
}