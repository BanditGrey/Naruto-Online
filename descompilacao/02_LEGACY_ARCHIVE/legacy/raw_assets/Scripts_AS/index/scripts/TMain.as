package
{
   import Logics.Agent.SParametersCore;
   import Logics.Agent.Spaces.ParametersSpace;
   import Processors_Mini.Accessories.TProcessorMiniLoad;
   import Processors_Mini.Accessories.TRightMenu;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageQuality;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.system.Security;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   use namespace ParametersSpace;
   
   public class TMain extends MovieClip
   {
      
      public static const STAGE_FrameRate:uint = 30;
      
      protected var FProcessorMiniLoad:TProcessorMiniLoad;
      
      protected var FRightMenu:TRightMenu;
      
      protected var FParameters:Object;
      
      protected var FApplicationInitialized:Boolean;
      
      protected var FParametersInitialized:Boolean;
      
      protected var FTimeID:uint;
      
      public function TMain()
      {
         super();
         if(stage != null)
         {
            this.Hack();
         }
         addEventListener(Event.ADDED,this.ApplicationOnAdded);
         addEventListener(Event.ENTER_FRAME,this.StageOnEnterFrame);
      }
      
      protected function Hack() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:DisplayObject = null;
         _loc1_ = this.numChildren;
         _loc2_ = int(_loc1_ - 1);
         while(_loc2_ >= 0)
         {
            this.removeChildAt(_loc2_);
            _loc2_--;
         }
      }
      
      protected function Initialize() : void
      {
         this.Initialize_Parameters(root.loaderInfo.parameters);
         this.Initialize_Display();
         this.Initialize_Processors();
         this.AnalyUser();
         this.FApplicationInitialized = true;
      }
      
      protected function Initialize_Parameters(param1:Object) : void
      {
         if(!this.FParametersInitialized)
         {
            Security.allowDomain("*");
            SParametersCore.CoerceProperties(param1);
            this.FParameters = param1;
            this.FParametersInitialized = true;
         }
      }
      
      protected function Initialize_Display() : void
      {
         stage.align = StageAlign.TOP_LEFT;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.quality = StageQuality.BEST;
         stage.frameRate = STAGE_FrameRate;
         this.FRightMenu = new TRightMenu();
         this.FRightMenu.Version = SParametersCore.ClientVersion.toString();
         stage.addChild(this.FRightMenu);
         this.contextMenu = this.FRightMenu.MyContextMenu;
         stage.showDefaultContextMenu = false;
      }
      
      protected function Initialize_Processors() : void
      {
         this.FProcessorMiniLoad = new TProcessorMiniLoad();
         this.FProcessorMiniLoad.OnLoadingCompleted = this.ProcessorOnLoadingCompleted;
         stage.addChild(this.FProcessorMiniLoad);
      }
      
      protected function AnalyUser() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("analyUser",SParametersCore.AgentID,1,SParametersCore.IsNewUser,SParametersCore.OperatorUserID,SParametersCore.ServerID);
         }
      }
      
      protected function ProcessorMiniLoadDispose() : void
      {
         clearTimeout(this.FTimeID);
         if(this.FProcessorMiniLoad.parent != null)
         {
            this.FProcessorMiniLoad.parent.removeChild(this.FProcessorMiniLoad);
         }
         this.FProcessorMiniLoad.Dispose();
         this.FProcessorMiniLoad = null;
         if(this.FRightMenu.parent != null)
         {
            this.FRightMenu.parent.removeChild(this.FRightMenu);
         }
         this.FRightMenu.Dispose();
         this.FRightMenu = null;
      }
      
      protected function ApplicationOnAdded(param1:Event) : void
      {
         this.Hack();
      }
      
      protected function StageOnEnterFrame(param1:Event) : void
      {
         if(stage == null)
         {
            return;
         }
         if(!this.FApplicationInitialized)
         {
            this.Initialize();
         }
         if(this.FApplicationInitialized)
         {
            removeEventListener(Event.ENTER_FRAME,this.StageOnEnterFrame);
         }
      }
      
      protected function ProcessorOnLoadingCompleted(param1:Object, param2:Object) : void
      {
         var _loc3_:* = undefined;
         _loc3_ = param2 as Sprite;
         stage.addChild(_loc3_);
         this.FTimeID = setTimeout(this.ProcessorMiniLoadDispose,1500);
      }
   }
}

