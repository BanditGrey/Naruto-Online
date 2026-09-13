package Processors.Game.Lobby.Exercise.UpdateList
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class TProcessorUpdateList extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH:uint = 527;
      
      protected static const SIZE_HIGHT:uint = 376;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 300;
      
      protected static const ITEM_STAMP:Number = 0;
      
      protected static const SINGLE_ITEM_STAMP:Number = 20;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FInitialized:Boolean;
      
      protected var FDescList:Vector.<String>;
      
      protected var FTitle:String;
      
      protected var FContent:String;
      
      protected var FContentText:TextField;
      
      public function TProcessorUpdateList(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FDescList = new Vector.<String>();
         this.FInitialized = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550136840);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_UpdateList") as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_WIDTH >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_HIGHT >> 1;
         this.FBTN_Close = this.FMC_Scene["BTN_Close"];
         this.FScrollBar = new TScrollBar(this.FMC_Scene.mc_list,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         this.FInitialized = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonOnClose,false,0,true);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FInitialized)
         {
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_UpdateList_LoadInfo_Ret,this.PerformPacket_SC_LoadInfoRet);
      }
      
      protected function UpdateUI() : void
      {
         if(!this.FInitialized)
         {
            return;
         }
         this.FMC_Scene.TF_Title.htmlText = this.FDescList[0];
         this.FScrollBar.Clear();
         this.FContentText = new TextField();
         this.FContentText.width = 590;
         this.FContentText.htmlText = this.FDescList[1];
         this.FContentText.height = this.FContentText.textHeight + 20;
         this.FScrollBar.AddItem(this.FContentText);
      }
      
      protected function ButtonOnClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.visible = true;
         this.UpdateUI();
      }
      
      public function PerformPacket_SC_LoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         _loc4_ = param1.Data;
         this.FDescList.length = 0;
         _loc3_ = _loc4_.readShort();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FDescList[_loc2_] = TUtilityString.FetchUTF(_loc4_);
            _loc2_++;
         }
         setTimeout(this.Mount,10000);
      }
   }
}

