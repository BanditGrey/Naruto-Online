package _98000155_fla
{
   import adobe.utils.*;
   import fl.motion.AnimatorFactory3D;
   import fl.motion.MotionBase;
   import fl.motion.motion_internal;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.sensors.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol145")]
   public dynamic class Timeline_9 extends MovieClip
   {
      
      public var TF_Return:TextField;
      
      public var TF_Desc1:TextField;
      
      public var TF_Desc0:TextField;
      
      public var MC_Max:MovieClip;
      
      public var MC_Icon:MovieClip;
      
      public var TF_Level:TextField;
      
      public var MC_Bar:MovieClip;
      
      public var MC_Tag:MovieClip;
      
      public var BTN_Feed:MovieClip;
      
      public var MC_Movie1:MovieClip;
      
      public var MC_Movie0:MovieClip;
      
      public var MC_Movie2:MovieClip;
      
      public var __animFactory_MC_Iconaf1:AnimatorFactory3D;
      
      public var __animArray_MC_Iconaf1:Array;
      
      public var ____motion_MC_Iconaf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_MC_Iconaf1_matArray__:Array;
      
      public var __motion_MC_Iconaf1:MotionBase;
      
      public var __animFactory_MC_Movie1af1:AnimatorFactory3D;
      
      public var __animArray_MC_Movie1af1:Array;
      
      public var ____motion_MC_Movie1af1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_MC_Movie1af1_matArray__:Array;
      
      public var __motion_MC_Movie1af1:MotionBase;
      
      public function Timeline_9()
      {
         super();
         if(this.__animFactory_MC_Iconaf1 == null)
         {
            this.__animArray_MC_Iconaf1 = new Array();
            this.__motion_MC_Iconaf1 = new MotionBase();
            this.__motion_MC_Iconaf1.duration = 1;
            this.__motion_MC_Iconaf1.overrideTargetTransform();
            this.__motion_MC_Iconaf1.addPropertyArray("visible",[true]);
            this.__motion_MC_Iconaf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_MC_Iconaf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_MC_Iconaf1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_MC_Iconaf1.is3D = true;
            this.__motion_MC_Iconaf1.motion_internal::spanStart = 0;
            this.____motion_MC_Iconaf1_matArray__ = new Array();
            this.____motion_MC_Iconaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_MC_Iconaf1_mat3DVec__[0] = 1;
            this.____motion_MC_Iconaf1_mat3DVec__[1] = 0;
            this.____motion_MC_Iconaf1_mat3DVec__[2] = 0;
            this.____motion_MC_Iconaf1_mat3DVec__[3] = 0;
            this.____motion_MC_Iconaf1_mat3DVec__[4] = 0;
            this.____motion_MC_Iconaf1_mat3DVec__[5] = 1;
            this.____motion_MC_Iconaf1_mat3DVec__[6] = 0;
            this.____motion_MC_Iconaf1_mat3DVec__[7] = 0;
            this.____motion_MC_Iconaf1_mat3DVec__[8] = 0;
            this.____motion_MC_Iconaf1_mat3DVec__[9] = 0;
            this.____motion_MC_Iconaf1_mat3DVec__[10] = 1;
            this.____motion_MC_Iconaf1_mat3DVec__[11] = 0;
            this.____motion_MC_Iconaf1_mat3DVec__[12] = 0.8;
            this.____motion_MC_Iconaf1_mat3DVec__[13] = 0.7;
            this.____motion_MC_Iconaf1_mat3DVec__[14] = 0;
            this.____motion_MC_Iconaf1_mat3DVec__[15] = 1;
            this.____motion_MC_Iconaf1_matArray__.push(new Matrix3D(this.____motion_MC_Iconaf1_mat3DVec__));
            this.__motion_MC_Iconaf1.addPropertyArray("matrix3D",this.____motion_MC_Iconaf1_matArray__);
            this.__animArray_MC_Iconaf1.push(this.__motion_MC_Iconaf1);
            this.__animFactory_MC_Iconaf1 = new AnimatorFactory3D(null,this.__animArray_MC_Iconaf1);
            this.__animFactory_MC_Iconaf1.addTargetInfo(this,"MC_Icon",0,true,0,true,null,-1);
         }
         if(this.__animFactory_MC_Movie1af1 == null)
         {
            this.__animArray_MC_Movie1af1 = new Array();
            this.__motion_MC_Movie1af1 = new MotionBase();
            this.__motion_MC_Movie1af1.duration = 1;
            this.__motion_MC_Movie1af1.overrideTargetTransform();
            this.__motion_MC_Movie1af1.addPropertyArray("visible",[true]);
            this.__motion_MC_Movie1af1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_MC_Movie1af1.addPropertyArray("blendMode",["normal"]);
            this.__motion_MC_Movie1af1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_MC_Movie1af1.is3D = true;
            this.__motion_MC_Movie1af1.motion_internal::spanStart = 0;
            this.____motion_MC_Movie1af1_matArray__ = new Array();
            this.____motion_MC_Movie1af1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_MC_Movie1af1_mat3DVec__[0] = 1;
            this.____motion_MC_Movie1af1_mat3DVec__[1] = 0;
            this.____motion_MC_Movie1af1_mat3DVec__[2] = 0;
            this.____motion_MC_Movie1af1_mat3DVec__[3] = 0;
            this.____motion_MC_Movie1af1_mat3DVec__[4] = 0;
            this.____motion_MC_Movie1af1_mat3DVec__[5] = 1;
            this.____motion_MC_Movie1af1_mat3DVec__[6] = 0;
            this.____motion_MC_Movie1af1_mat3DVec__[7] = 0;
            this.____motion_MC_Movie1af1_mat3DVec__[8] = 0;
            this.____motion_MC_Movie1af1_mat3DVec__[9] = 0;
            this.____motion_MC_Movie1af1_mat3DVec__[10] = 1;
            this.____motion_MC_Movie1af1_mat3DVec__[11] = 0;
            this.____motion_MC_Movie1af1_mat3DVec__[12] = 58.900002;
            this.____motion_MC_Movie1af1_mat3DVec__[13] = 55.299999;
            this.____motion_MC_Movie1af1_mat3DVec__[14] = 0;
            this.____motion_MC_Movie1af1_mat3DVec__[15] = 1;
            this.____motion_MC_Movie1af1_matArray__.push(new Matrix3D(this.____motion_MC_Movie1af1_mat3DVec__));
            this.__motion_MC_Movie1af1.addPropertyArray("matrix3D",this.____motion_MC_Movie1af1_matArray__);
            this.__animArray_MC_Movie1af1.push(this.__motion_MC_Movie1af1);
            this.__animFactory_MC_Movie1af1 = new AnimatorFactory3D(null,this.__animArray_MC_Movie1af1);
            this.__animFactory_MC_Movie1af1.addTargetInfo(this,"MC_Movie1",0,true,0,true,null,-1);
         }
      }
   }
}

