KhaParticle
===========
Author: Sidar Talei

**Simple particle system for kha**


How to use:
-
For now simply copy the files to your Source folder

    var img:Image = Loader.the.getImage("particle");

	p = new ParticleSystem(1000, img);
	var e:RadialEmitter = new RadialEmitter();
	
	e.rate = 100; 			//particles per second
	e.speed = 0; 			//particle velocity
	e.duration = 1;			//Duration of emission
	e.loop = true;			//If true emission continues after duration
	e.amountPerRate = 1;	//Amount of particles per rate
	e.maxLife = 2;			//Maximum life of a particles in seconds
	e.lifeVariation = 1;	//[0-1]Random life between 0 and maxlife
	e.edgeSpawn = true; 	//Spawns at the edge of the emitter
							//property of RadialEmitter
	e.maxRotationVel = 10;	//Rotation speed.

Adding burst:
-
	var b:BurstProp = new BurstProp();
	b.amount = 100; //Amount to emit 
	b.time = .5;	//Every half a second
	e.addBurst(b);	//Add to the emitter

Adding modifiers:
-

	//Add color change over life time
	var c:ColorModifier = new ColorModifier();
	//Color and position -> [0-1]
	c.pushColor(Color.fromValue(0xFFFFFF00), 0);
	c.pushColor(Color.fromValue(0xFFFF00FF), 1);
	p.addModifier(c);

	//Add Fader over life time
	p.addModifier(new FadeModifier(FadeType.FADE_OUT)); //fades out

	//Add gravity 
	p.addModifier(new GravityModfier(0,250)); // adds 250 to y over time

	//Scale Up over life time. Multiplier 1.5;
	p.addModifier(new ScaleModifier(ScaleType.SCALE_UP, 1.5));

- Modifiers can be used with multiple ParticleSystem objects

Updating & Rendering
-
ParticleSystems need to be updated:

	function update() : Void
	{
		p.update();
	}

	function render(painter:Painter) : Void
	{	
		p.render(painter);
	}

Notes
-

- If you want to change the position of the emitter simply change the x and y value on the particle system object. This will automatically update the position of the emitter as well.
- ScaleModifier can make use of a Spline curve (kha.scene.Spline) but currently it's pretty heavy. When using lots of particles avoid using a spline. Eventually most basic modifiers will have the option to include a curve over life time.