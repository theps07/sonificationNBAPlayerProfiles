(////////////////////////////////RUN THIS BLOCK FIRST///////////////////////////////////////
s.boot;
//SynthDefs
//Sounds used for the project.
//chordysaw: a saw synth being routed through a band-passed filter and a low-shelf filter.
//pluckysaw: also a saw synth but with a frequency below 20hz causing in to generate taps      with a lot of harmonic potential

SynthDef(\chordysaw, {
	arg atk=2, sus=0, rel=3, c1=1, c2=(-1),
	freq=500, detune=0.2, pan=0, cfhzmin=0.1, cfhzmax=0.3,
	cfmin=500, cfmax=2000, rqmin=0.1, rqmax=0.2,
	lsf=200, ldb=0, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0], [atk,sus,rel],[c1,0,c2]), doneAction:2);
	sig = Saw.ar(freq*{LFNoise1.kr(0.5, detune).midiratio}!2);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin, cfhzmax)
		).exprange(cfmin, cfmax)}!2,
		{LFNoise1.kr(0,1).exprange(rqmin, rqmax)}!2
	);
	sig = BLowShelf.ar(sig, lsf, 0.5, ldb);
	sig = Balance2.ar(sig[0], sig[1], pan);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;

SynthDef(\pluckysaw, {
	arg atk=2, sus=0, rel=3, c1=1, c2=(-1),
	freq=500, detune=0.2, pan=0, cfhzmin=0.1, cfhzmax=0.3,
	cfmin=500, cfmax=2000, rqmin=0.1, rqmax=0.2,
	lsf=200, ldb=0, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0], [atk,sus,rel],[c1,0,c2]), doneAction:2);
	sig = Saw.ar(freq*{LFNoise1.kr(0.5, detune).midiratio}!2);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin, cfhzmax)
		).exprange(cfmin, cfmax)}!2,
		{LFNoise1.kr(0,1).exprange(rqmin, rqmax)}!2
	);
	sig = BLowShelf.ar(sig, lsf, 0.5, ldb);
	sig = Balance2.ar(sig[0], sig[1], pan);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;
)

(////////////////////////////////RUN THIS BLOCK SECOND///////////////////////////////////////
//DATA MANIPULATION

//READING THE DATA
x = CSVFileReader.read(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "PS_DatSon Transposed.csv", true, true).postcs; //CSV File Read

//DATA SEGMENTATION
Array.fill(50, {arg i; i}).do({arg i;
	x[i].removeAt(0).postln; //Removes first element (a string)
	x[i] = x[i].asFloat;//Converts strings to floats
	});
);

(////////////////////////////////RUN THIS BLOCK THIRD///////////////////////////////////////

//Some Functions

//FINDS MAX DATA
~dataMax = {
	arg counter;
	var dataMax;
	dataMax = [0, 10, 20, 30, 40].collect({arg item, i; ([]++x[item+counter].maxItem).maxItem;});
	dataMax = dataMax.maxItem;
};

//FINDS MIN DATA
~dataMin = {
	arg counter;
	var dataMin;
	dataMin = [0, 10, 20, 30, 40].collect({arg item, i; ([]++x[item+counter].minItem).minItem;});
	dataMin = dataMin.minItem;
};

//NORMALIZES DATA
~normalize = {
	arg data, min, max;
	var nData;
	nData = ((data-min)/(max-min));
	nData = (nData+1).ratiomidi.round(1) + 1;
};

)

(////////////////////////////////RUN THIS BLOCK FOURTH///////////////////////////////////////
~transpose = 52; //master transpose
t = TempoClock.new(60/60).permanent_(true); //master tempo

//creating collections to store data
~data = ();
~data.mj = ();  //Michael Jordan's data
~data.lbj = (); //LeBron James's data
~data.maj = (); //Magic Johnson's data
~data.lb = ();  //Larry Bird's data
~data.kaj = (); //Kareem Abdul Jabbar's data

//MJ
~data.mj[1] = x[1];
~data.mj[2] = ~normalize.value(x[2], ~dataMin.value(2), ~dataMax.value(2));
~data.mj[3] = ~normalize.value(x[3], ~dataMin.value(3), ~dataMax.value(3));
~data.mj[4] = ~normalize.value(x[4], ~dataMin.value(4), ~dataMax.value(4));
~data.mj[5] = ~normalize.value(x[5], ~dataMin.value(5), ~dataMax.value(5));
~data.mj[6] = ~normalize.value(x[6], ~dataMin.value(6), ~dataMax.value(6));
~data.mj[7] = ~normalize.value(x[7], ~dataMin.value(7), ~dataMax.value(7));
~data.mj[8] = ~normalize.value(x[8], ~dataMin.value(8), ~dataMax.value(8));
~data.mj[9] = ~normalize.value(x[9], ~dataMin.value(2), ~dataMax.value(2));
~data.mj[10] = ~data.mj[1].size.collect({arg i; [~data.mj[6][i], ~data.mj[7][i]]+ ~transpose;});


//LBJ
~data.lbj[1] = x[11];
~data.lbj[2] = ~normalize.value(x[12], ~dataMin.value(2), ~dataMax.value(2));
~data.lbj[3] = ~normalize.value(x[13], ~dataMin.value(3), ~dataMax.value(3));
~data.lbj[4] = ~normalize.value(x[14], ~dataMin.value(4), ~dataMax.value(4));
~data.lbj[5] = ~normalize.value(x[15], ~dataMin.value(5), ~dataMax.value(5));
~data.lbj[6]= ~normalize.value(x[16], ~dataMin.value(6), ~dataMax.value(6));
~data.lbj[7]= ~normalize.value(x[17], ~dataMin.value(7), ~dataMax.value(7));
~data.lbj[8] = ~normalize.value(x[18], ~dataMin.value(8), ~dataMax.value(8));
~data.lbj[9]= ~normalize.value(x[19], ~dataMin.value(2), ~dataMax.value(2));
~data.lbj[10] = ~data.lbj[1].size.collect({arg i; [~data.lbj[6][i], ~data.lbj[7][i]]+ ~transpose;});


//MAJ
~data.maj[1] = x[21];
~data.maj[2] = ~normalize.value(x[22], ~dataMin.value(2), ~dataMax.value(2));
~data.maj[3] = ~normalize.value(x[23], ~dataMin.value(3), ~dataMax.value(3));
~data.maj[4] = ~normalize.value(x[24], ~dataMin.value(4), ~dataMax.value(4));
~data.maj[5] = ~normalize.value(x[25], ~dataMin.value(5), ~dataMax.value(5));
~data.maj[6] = ~normalize.value(x[26], ~dataMin.value(6), ~dataMax.value(6));
~data.maj[7] = ~normalize.value(x[27], ~dataMin.value(7), ~dataMax.value(7));
~data.maj[8] = ~normalize.value(x[28], ~dataMin.value(8), ~dataMax.value(8));
~data.maj[9] = ~normalize.value(x[29], ~dataMin.value(2), ~dataMax.value(2));
~data.maj[10] = ~data.maj[1].size.collect({arg i; [~data.maj[6][i], ~data.maj[7][i]]+ ~transpose;});


//LB
~data.lb[1] = x[31];
~data.lb[2] = ~normalize.value(x[32], ~dataMin.value(2), ~dataMax.value(2));
~data.lb[3]= ~normalize.value(x[33], ~dataMin.value(3), ~dataMax.value(3));
~data.lb[4] = ~normalize.value(x[34], ~dataMin.value(4), ~dataMax.value(4));
~data.lb[5] = ~normalize.value(x[35], ~dataMin.value(5), ~dataMax.value(5));
~data.lb[6] = ~normalize.value(x[36], ~dataMin.value(6), ~dataMax.value(6));
~data.lb[7]= ~normalize.value(x[37], ~dataMin.value(7), ~dataMax.value(7));
~data.lb[8] = ~normalize.value(x[38], ~dataMin.value(8), ~dataMax.value(8));
~data.lb[9] = ~normalize.value(x[39], ~dataMin.value(2), ~dataMax.value(2));
~data.lb[10] = ~data.lb[1].size.collect({arg i; [~data.lb[6][i], ~data.lb[7][i]]+ ~transpose;});


//KAJ
~data.kaj[1] = x[41];
~data.kaj[2] = ~normalize.value(x[42], ~dataMin.value(2), ~dataMax.value(2));
~data.kaj[3] = ~normalize.value(x[43], ~dataMin.value(3), ~dataMax.value(3));
~data.kaj[4] = ~normalize.value(x[44], ~dataMin.value(4), ~dataMax.value(4));
~data.kaj[5]= ~normalize.value(x[45], ~dataMin.value(5), ~dataMax.value(5));
~data.kaj[6] = ~normalize.value(x[46], ~dataMin.value(6), ~dataMax.value(6));
~data.kaj[7]= ~normalize.value(x[47], ~dataMin.value(7), ~dataMax.value(7));
~data.kaj[8] = ~normalize.value(x[48], ~dataMin.value(8), ~dataMax.value(8));
~data.kaj[9] = ~normalize.value(x[49], ~dataMin.value(2), ~dataMax.value(2));
~data.kaj[10] = ~data.kaj[1].size.collect({arg i; [~data.kaj[6][i], ~data.kaj[7][i]]+ ~transpose;});
)

(////////////////////////////////RUN THIS BLOCK FIFTH///////////////////////////////////////

//Function that will generate the composition
~sonification = {
	arg data;
	var chords, plucks, mix;

	chords = Pbind(
		\instrument, \chordysaw,
		\dur, Prand([1,0.5], data[1].size),
		\midinote, Pseq(data[10], data[1].size), //spg, bpg
		\detune, Pseq(data[4].pow(2)/150, data[1].size), //rpg
		\cfmin, 100,
		\cfmax, 1500,
		\rqmin, Pexprand(0.01, 0.15, data[1].size),
		\atk, 0.1,
		\rel, 2,
		\ldb, 6,
		\amp, 0.375,
		\out, 0,
	);

	plucks = Pbind(
		\instrument, \pluckysaw,
		\dur, Pseq(data[2]/16, data[1].size), //gp
		\freq, Pseq(data[5].pow(2)/10, data[1].size), //apg
	    \detune, 0,
		\rqmin, Pseq(data[9]*0.001, data[1].size), //fg
	    \rqmax, Pkey(\rqmin) + 0.003,
		\cfmin, Pseq((data[3]+64).midicps, data[1].size) * Pseq([1,2,4], data[1].size), //ppg
	    \cfmax, Pkey(\cfmin) * Pwhite(1.008, 1.025, data[1].size),
		\atk, 0.001,
		\sus, 1,
		\rel, 1,
		\amp, 0.25/Pkey(\rqmin).sqrt,
		\out, 0,
	);

	mix = Ppar([chords, plucks]);


}
)

(////////////////////////////////RUN THIS BLOCK LAST///////////////////////////////////////
/////////////////////////////////////MAPPINGS////////////////////////////////////////////
//Number of years = Length of sequence (all events are spaced equally, sequences that end early signify shorter playing years)
//Games played = Duration of the pulses
//PPG (Points) = Pitch of pulses (higher pitch correleates to more points per game)
//RPG (Rebounds) = Amount of Detune (more detuned pads equate to better rebounding)
//APG (Assists) = Frequency of pulses (Faster pulses correlate to more assists)
//SPG (Steals) = Combines with blocks to form an interval
//BPG (Blocks) = Combimes with steals to form an interval
//FG (Player Efficiency) = Bandpass filter quality (More efficiency equates to a more discernable pitch for the pulses)
~dir = PathName(thisProcess.nowExecutingPath).parentPath ++ "dSonFinal_Puru.wav";
Routine({
	s.recSampleFormat = "int24";
	s.recHeaderFormat = "WAV";
    s.record(~dir, duration:t.tempo*96);

	wait(0.02);

	~finalSonification = Ptpar([
		0.0,
		~sonification.value(~data.mj),
		t.tempo*18,
		~sonification.value(~data.lbj),
		t.tempo*36,
		~sonification.value(~data.maj),
		t.tempo*54,
		~sonification.value(~data.lb),
		t.tempo*72,
		~sonification.value(~data.kaj)
	]).play(t, quant:1);
}).play;
)

s.makeWindow

