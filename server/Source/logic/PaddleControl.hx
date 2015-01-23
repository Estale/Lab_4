package logic;
/* Логика доски игрока */
import visual.Paddle;
import openfl.display.Stage;

class PaddleControl {

	var playerPaddle:Paddle;
	var stage:Stage;

	public function new (playerPaddle:Paddle, stage:Stage) {
		this.playerPaddle = playerPaddle;
		this.stage = stage;
	}

	/* Действие на каждый кадр */
	public function move () {
		/* Передвинем к курсору мыши */
		playerPaddle.y = stage.mouseY;
		playerPaddle.z = stage.mouseX;

		/* Не дадим доске выйти за края экрана */
		if(playerPaddle.y - playerPaddle.height/2 < 0){
			playerPaddle.y = playerPaddle.height/2;
		} else if(playerPaddle.y + playerPaddle.height/2 > Main.SCREEN_H){
			playerPaddle.y = Main.SCREEN_H - playerPaddle.height/2;
		}
	}
}