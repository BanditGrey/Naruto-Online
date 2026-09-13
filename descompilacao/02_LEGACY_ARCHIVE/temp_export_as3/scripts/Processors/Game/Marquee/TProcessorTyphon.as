package Processors.Game.Marquee
{
   import Components.HyperStrings.TUIHyperStringMarquee;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TAnimationSequence;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.HyperStrings.THyperString;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Common.TProcessorOverView;
   import Processors.Game.Marquee.Data.THyperStringFontSheetMarquee;
   import Rendering.HyperStrings.Data.THyperStringFontSheet;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_LOBBY;
   import Resources.Constants.CONST_MODULES;
   import Utilities.UI.Marquees.TUtilityUIMarquee;
   import flash.display.Bitmap;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TProcessorTyphon extends TProcessorOverView
   {
      
      public static const SEQUENCEID_Default:uint = 0;
      
      protected static const CAPACITY_BARS:uint = 1;
      
      protected static const SIZE_MarqueeX:int = 80;
      
      protected static const SIZE_MarqueeY:int = 20;
      
      protected static const SIZE_MarqueeWidth:int = 800;
      
      protected static const SIZE_Marqueeheight:int = 40;
      
      protected var FHyperStrings:Vector.<THyperString>;
      
      protected var FFontSheet:THyperStringFontSheet;
      
      protected var FUIHyperStringMarquees:Vector.<TUIHyperStringMarquee>;
      
      protected var FTimerThree:Timer = null;
      
      protected var EffectBaseGlow:TEffectBaseGlow;
      
      protected var FBitmap:Bitmap = null;
      
      protected var FBitmapIcon:Bitmap = null;
      
      protected var Texture:TTexture = null;
      
      protected var Textures:TResourceRepositoryTexture = null;
      
      protected var FAnimationSequence:TAnimationSequence = null;
      
      public function TProcessorTyphon(param1:TUIComponent)
      {
         super(param1);
         FBoundsClient.Width = 0;
         FBoundsClient.Height = 0;
         this.ConstructorUIHyperStringMarquee();
         this.FHyperStrings = new Vector.<THyperString>();
         this.mouseEnabled = false;
         FResourcesState = RESOURCESSTATE_UIRequest;
         this.FTimerThree = new Timer(5000);
         this.FTimerThree.addEventListener(TimerEvent.TIMER,this.TimerEventHandle);
         this.FTimerThree.stop();
         this.FBitmap = new Bitmap();
         this.FBitmap.visible = false;
         this.FBitmapIcon = new Bitmap();
      }
      
      protected function ConstructorUIHyperStringMarquee() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUIHyperStringMarquee = null;
         this.FUIHyperStringMarquees = new Vector.<TUIHyperStringMarquee>(CAPACITY_BARS);
         this.FFontSheet = new THyperStringFontSheetMarquee();
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_BARS)
         {
            _loc2_ = new TUIHyperStringMarquee(this);
            _loc2_.X = 0;
            _loc2_.Y = SIZE_Marqueeheight * _loc1_ + 50;
            _loc2_.FontSheet = this.FFontSheet;
            _loc2_.UIMessageBypassing = true;
            this.FUIHyperStringMarquees[_loc1_] = _loc2_;
            this.FUIHyperStringMarquees[_loc1_].visible = false;
            this.FUIHyperStringMarquees[_loc1_].TextureExpression = this.Texture;
            this.FUIHyperStringMarquees[_loc1_].mouseChildren = false;
            this.FUIHyperStringMarquees[_loc1_].mouseEnabled = false;
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfCommon.LoadPrimary(CONST_COMMON.RESOURCESID_Swf_Common);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUIHyperStringMarquee = null;
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_BARS)
         {
            _loc2_ = this.FUIHyperStringMarquees[_loc1_];
            TUtilityUIMarquee.ResourcesDispatch(_loc2_);
            this.EffectBaseGlow = new TEffectBaseGlow();
            this.EffectBaseGlow.SetParameters(_loc2_,16315572,1);
            this.EffectBaseGlow.visible = false;
            this.EffectBaseGlow.Stop();
            _loc1_++;
         }
         this.FUIHyperStringMarquees[0].addChild(this.FBitmap);
         this.FUIHyperStringMarquees[0].addChild(this.FBitmapIcon);
         this.Textures = SResourcesCore.TexturesLobby;
         this.Texture = this.Textures.GetTextureByIdentifier(CONST_LOBBY.RESOURCESID_TextureVital_Expression);
         this.FUIHyperStringMarquees[0].TextureExpression = this.Texture;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:THyperString = null;
         if(this.FUIHyperStringMarquees[0].Visible)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FUIHyperStringMarquees.length)
            {
               this.FUIHyperStringMarquees[_loc1_].SketchingPerform_Copy();
               this.FUIHyperStringMarquees[_loc1_].RenderingPerform_HyperString_Copy();
               _loc1_++;
            }
         }
         if(this.FBitmap.visible)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_Tryout,this.FBitmap,CONST_MODULES.MODULE_Typhon,90000001);
         }
         if(this.EffectBaseGlow)
         {
            if(this.EffectBaseGlow.visible)
            {
               this.EffectBaseGlow.Run();
               this.FBitmap.y = this.FUIHyperStringMarquees[0].Sketcher.Y - 12;
               this.FBitmap.x = this.FUIHyperStringMarquees[0].Sketcher.X - this.FBitmap.width;
               this.FBitmapIcon.y = this.FUIHyperStringMarquees[0].Sketcher.Y - 12;
               this.FBitmapIcon.x = this.FUIHyperStringMarquees[0].Sketcher.Width + 10;
            }
         }
         super.LogicsPerform();
      }
      
      protected function TimerEventHandle(param1:TimerEvent) : void
      {
         this.NImeia();
      }
      
      protected function NImeia() : void
      {
         var _loc1_:THyperString = null;
         if(this.FHyperStrings.length > 0)
         {
            _loc1_ = this.FHyperStrings.shift();
            this.FUIHyperStringMarquees[0].Animate(_loc1_);
            _loc1_.StubReferences.Dereference(this);
            this.FUIHyperStringMarquees[0].Visible = true;
            this.EffectBaseGlow.visible = true;
            this.FBitmap.visible = true;
            this.EffectBaseGlow.Run();
            this.FTimerThree.reset();
            this.FTimerThree.start();
         }
         else
         {
            this.FTimerThree.reset();
            this.FUIHyperStringMarquees[0].Visible = false;
            this.EffectBaseGlow.visible = false;
            this.FBitmap.visible = false;
            if(this.FBitmapIcon.bitmapData)
            {
               this.FBitmapIcon.bitmapData.dispose();
            }
            this.EffectBaseGlow.Stop();
         }
      }
      
      public function StartMarquee(param1:Object) : void
      {
         var _loc2_:THyperString = null;
         if(this.FBitmapIcon.bitmapData)
         {
            this.FBitmapIcon.bitmapData.dispose();
         }
         if(param1 is THyperString)
         {
            _loc2_ = param1 as THyperString;
            _loc2_.StubReferences.Reference(this);
            this.FHyperStrings.push(_loc2_);
         }
         this.NImeia();
      }
   }
}

