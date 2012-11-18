package fr.hyperfiction.hypertouch.gestures;

import fr.hyperfiction.hypertouch.enums.GesturePhases;
import fr.hyperfiction.hypertouch.HyperTouch;
import fr.hyperfiction.hypertouch.gestures.AGesture;
import fr.hyperfiction.hypertouch.events.TransformGestureEvent;

#if android
import nme.JNI;
#end

#if cpp
import cpp.Lib;
import nme.Lib;
#end

/**
 * ...
 * @author shoe[box]
 */
class GesturePan extends AGesture{	

	#if android
	private static inline var ANDROID_CLASS : String = 'fr/hyperfiction/hypertouch/GesturePan';
	#end

	#if mobile
	private static var eval_callback_pan = Lib.load( "hypertouch" , "set_callback_pan", 1);
	#end

	// -------o constructor
		
		/**
		* constructor
		*
		* @param	
		* @return	void
		*/
		public function new() {
			super( );
		}
	
	// -------o public
				
				

	// -------o protected	

		/**
		* 
		* 
		* @private
		* @return	void
		*/
		override private function _activate( ) : Void{
			#if android
			_android( );
			#end	

			#if cpp
			eval_callback_pan( _onPan );
			#end
		}

		#if android

		/**
		* 
		* 
		* @private
		* @return	void
		*/
		private function _android( ) : Void{
			var f = JNI.createStaticMethod( ANDROID_CLASS , 'getInstance' , '()Lfr/hyperfiction/hypertouch/GesturePan;');
			_java_instance = f( );				
		}

		#end	

		/**
		* 
		* 
		* @private
		* @return	void
		*/
		private function _onPan( a : Array<Dynamic> ) : Void{
			
			var ev = new TransformGestureEvent( GESTURE_PAN , a[1] , a[2] , 1.0 , 1.0 , 1.0 );
			
			var id_phase = a[ 0 ];
			var phase = START;
			if( id_phase == 1 )
				phase = UPDATE;
			else if( id_phase == 2 )
				phase = END;

			//
				ev.phase = phase;
			
			#if android
				ev.pressure = a[5];
			#end

			stage_emit( ev );
			//onPan( iPhase , fx , fy , vx , vy , pressure );

		}

	// -------o misc
	
}