package Processors.Game.Lobby.Exercise.DragonBoat
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DRAGONBOAT;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SHORTCUTS;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.ByteArray;
   
   public class TProcessorDragonBoat extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH:uint = 600;
      
      protected static const SIZE_HIGHT:uint = 345;
      
      public static const GET_AWARD_SUCCEED:uint = 0;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Goto:SimpleButton;
      
      protected var FInitialized:Boolean;
      
      protected var FGotoURL:String;
      
      protected var FEndTime:int;
      
      protected var FOnOpenActivity:Function;
      
      public function TProcessorDragonBoat(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FInitialized = false;
         SetUIModuleID(CONST_MODULES.ACTIVE_Test);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_DRAGONBOAT.RESOURCESID_SWF_DragonBoat);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_DRAGONBOAT.RESOURCE_ClassName_DragonBoat) as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_WIDTH >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_HIGHT >> 1;
         this.FBTN_Close = this.FMC_Scene[CONST_DRAGONBOAT.RESOURCE_Link_BTN_Close];
         this.FBTN_Goto = this.FMC_Scene[CONST_DRAGONBOAT.RESOURCE_Link_BTN_Goto];
         this.FInitialized = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonOnClose,false,0,true);
         this.FBTN_Goto.addEventListener(MouseEvent.CLICK,this.ButtonOnGoto,false,0,true);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FInitialized)
         {
            if(this.FEndTime <= STimingCore.GetServerTick())
            {
               SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat,false);
               if(this.visible)
               {
                  ProcessorClose();
               }
               if(this.FOnOpenActivity != null)
               {
                  this.FOnOpenActivity();
               }
            }
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
      }
      
      protected function PerformPacket_SC_OpenActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = int(_loc2_.readUnsignedByte());
         var _loc4_:Boolean = _loc3_ == 0 ? false : true;
         this.FEndTime = _loc2_.readUnsignedInt();
         this.FGotoURL = TUtilityString.FetchUTF(_loc2_);
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_DragonBoat,_loc4_);
         if(!_loc4_ && this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity();
         }
      }
      
      protected function ButtonOnClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function ButtonOnGoto(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest(this.FGotoURL),"_about");
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
      }
      
      public function get OnOpenActivity() : Function
      {
         return this.FOnOpenActivity;
      }
      
      public function set OnOpenActivity(param1:Function) : void
      {
         this.FOnOpenActivity = param1;
      }
   }
}

