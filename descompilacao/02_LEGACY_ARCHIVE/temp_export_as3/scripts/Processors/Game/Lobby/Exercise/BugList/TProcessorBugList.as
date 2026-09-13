package Processors.Game.Lobby.Exercise.BugList
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.utils.ByteArray;
   
   public class TProcessorBugList extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH:uint = 383;
      
      protected static const SIZE_HIGHT:uint = 362;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 150;
      
      protected static const ITEM_STAMP:Number = 0;
      
      protected static const SINGLE_ITEM_STAMP:Number = 20;
      
      protected static const MAX_TEXT_LENGTH:int = 400;
      
      protected static const TAB_COUNT:int = 4;
      
      protected static const STRING_SEND_SUCCESS:String = "O problema foi submetido,\n a resposta será enviada para o endereço de email";
      
      protected var FMC_Scene:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FBTN_Close:MovieClip;
      
      protected var FBtn_Commit:MovieClip;
      
      protected var FInitialized:Boolean;
      
      protected var FInfoType:int;
      
      protected var FDescList:Vector.<String>;
      
      protected var FTitle:String;
      
      protected var FContent:String;
      
      protected var FTF_BugText:TextField;
      
      public function TProcessorBugList(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FDescList = new Vector.<String>();
         this.FInitialized = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550136841);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_BugList") as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_WIDTH >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_HIGHT >> 1;
         this.FBTN_Close = this.FMC_Scene["Btn_Cancel"];
         this.FBtn_Commit = this.FMC_Scene["Btn_Commit"];
         this.FScrollBar = new TScrollBar(this.FMC_Scene.mc_list,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         this.FInitialized = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         super.ResourcesPerform_UILocations();
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            this.FMC_Scene["MC_Tab" + _loc1_].buttonMode = true;
            this.FMC_Scene["MC_Tab" + _loc1_].gotoAndStop(_loc1_ + 1);
            this.FMC_Scene["MC_Tab" + _loc1_].MC_Select.visible = false;
            this.FMC_Scene["MC_Tab" + _loc1_].addEventListener(MouseEvent.CLICK,this.ButtonTabOnClick,false,0,true);
            this.FMC_Scene["MC_Tab" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonTabOnOver,false,0,true);
            this.FMC_Scene["MC_Tab" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,this.ButtonTabOnOut,false,0,true);
            _loc1_++;
         }
         this.FMC_Scene["MC_Tab0"].MC_Select.visible = true;
         TGameUtil.setButtonMode(this.FBtn_Commit,true);
         this.FBtn_Commit.addEventListener(MouseEvent.CLICK,this.ButtonSendOnClick,false,0,true);
         TGameUtil.setButtonMode(this.FBTN_Close,true);
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
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BugList_SendInfo_Ret,this.PerformPacket_SC_SendInfoRet);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         if(!this.FInitialized)
         {
            return;
         }
         this.FTF_BugText = new TextField();
         this.FTF_BugText.textColor = 16777215;
         this.FTF_BugText.multiline = true;
         this.FTF_BugText.type = TextFieldType.INPUT;
         this.FTF_BugText.addEventListener(Event.CHANGE,this.onTextInput);
         this.FTF_BugText.maxChars = MAX_TEXT_LENGTH;
         this.FScrollBar.Clear();
         this.FTF_BugText.width = 330;
         this.FTF_BugText.height = 170;
         this.FScrollBar.AddItem(this.FTF_BugText);
      }
      
      protected function ButtonOnClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function onTextInput(param1:Event) : void
      {
      }
      
      protected function ButtonTabOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(_loc2_ != this.FInfoType)
         {
            this.FInfoType = _loc2_;
            _loc3_ = 0;
            while(_loc3_ < TAB_COUNT)
            {
               if(_loc3_ == _loc2_)
               {
                  this.FMC_Scene["MC_Tab" + _loc3_].MC_Select.visible = true;
               }
               else
               {
                  this.FMC_Scene["MC_Tab" + _loc3_].MC_Select.visible = false;
               }
               _loc3_++;
            }
         }
         this.FMC_Scene["MC_Tab" + _loc2_].filters = [];
      }
      
      protected function ButtonTabOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(_loc2_ != this.FInfoType)
         {
            this.FMC_Scene["MC_Tab" + _loc2_].filters = [TGameUtil.highLightFilters];
         }
      }
      
      protected function ButtonTabOnOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(_loc2_ != this.FInfoType)
         {
            this.FMC_Scene["MC_Tab" + _loc2_].filters = [];
         }
      }
      
      protected function ButtonSendOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BugList_SendInfo_Req);
         _loc2_.Data.writeUnsignedInt(this.FInfoType + 1);
         TUtilityString.FlushUTF(_loc2_.Data,this.FTF_BugText.text);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         TGameUtil.setButtonMode(this.FBtn_Commit,false);
      }
      
      public function PerformPacket_SC_SendInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         TGameUtil.setButtonMode(this.FBtn_Commit,true);
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
         }
         else
         {
            FOnEffectText(this,STRING_SEND_SUCCESS);
            ProcessorClose();
         }
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
   }
}

