function update(){
    if (animation.curAnim.name == "singLEFT"){
        camera.scroll.x -= 1;
    }

    if (animation.curAnim.name == "singDOWN"){
        camera.scroll.y += 1;
    }

    if (animation.curAnim.name == "singUP"){
        camera.scroll.y -= 1;
    }

    if (animation.curAnim.name == "singRIGHT"){
        camera.scroll.x += 1;
    }
}