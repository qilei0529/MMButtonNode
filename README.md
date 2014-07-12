#MMButtonNode

----
Simple SpriteKit Button Class



## Example

	
	MMButtonNode * btn;	
    btn = [MMButtonNode button:RGBA(255, 0, 100, 1) size:CGSizeMake(50, 50)];
    btn.text = @"Hello, I am Button";
    
    [btn addAction:^{
        [self onBtnClick:btn];
        //do any thing you like;
    }];
   
    
    
    
    
    

    
