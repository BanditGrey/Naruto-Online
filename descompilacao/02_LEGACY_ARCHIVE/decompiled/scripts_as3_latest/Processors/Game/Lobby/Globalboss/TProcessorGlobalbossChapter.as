package Processors.Game.Lobby.Globalboss
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Globalboss.TGlobalbossChapter;
   import Logics.SLogicsCore;
   import Logics.Streamization.Globalboss.TUnstreamizerGlobalboss;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorGlobalbossChapter extends TProcessorLobbyWindows
   {
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_List:MovieClip;
      
      protected var Spr:MovieClip;
      
      protected var BTN_Close:SimpleButton;
      
      protected var FUnstreamizerGlobalboss:TUnstreamizerGlobalboss;
      
      protected var FGlobalbossChapter:TGlobalbossChapter;
      
      protected var FGlobalbossAward:TProcessorGlobalbossAward;
      
      protected var FGlobalbossLevel:int;
      
      public var OnOpenGlobalboss:Function;
      
      public var UpdateChapterReward:Function;
      
      public function TProcessorGlobalbossChapter(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FGlobalbossAward = new TProcessorGlobalbossAward(param1);
         this.FGlobalbossAward.OnInventoryOver = UIComponentsHintOnOver;
         this.FGlobalbossAward.OnInventoryOut = UIComponentsHintOnOut;
         this.FUnstreamizerGlobalboss = new TUnstreamizerGlobalboss();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.Spr = TUtilityReflection.CreateDisplayObjectInstance("MC_globalbossChapter") as MovieClip;
         addChild(this.Spr);
         this.Spr.x = (FUICore.StageWidth - this.Spr.width) / 2;
         this.Spr.y = (FUICore.StageHeight - this.Spr.height) / 2;
         this.FMC_List = this.Spr["mc_list"];
         this.FScrollBar = new TScrollBar(this.FMC_List,380,false,0,75);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.Spr.btn_close.addEventListener(MouseEvent.CLICK,this.OnCloseWindow);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_GlobalBoss_Chapter_Ret,this.PerformPacket_SC_Chapter_Ret);
      }
      
      protected function PerformPacket_SC_Chapter_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerGlobalboss.UnstreamizationGlobalbossNewChapter(_loc2_,null,null);
         this.FGlobalbossChapter = this.FGlobalbossLevel == 1 ? SLogicsCore.GlobalbossChapter : SLogicsCore.GlobalbossChapterNew;
         if(FIsResourcesLoadCompleted)
         {
            this.ConstructScrollbar();
         }
         if(this.UpdateChapterReward != null)
         {
            this.UpdateChapterReward();
         }
      }
      
      protected function ConstructScrollbar() : void
      {
         var _loc1_:TUIGlobalBossChapter = null;
         this.FScrollBar.Clear();
         while(this.FGlobalbossChapter)
         {
            _loc1_ = new TUIGlobalBossChapter(this);
            this.FScrollBar.AddItem(_loc1_);
            _loc1_.setData(this.FGlobalbossChapter);
            _loc1_.OnOpenGlobalboss = this.ProcessorOpenGlobalboss;
            _loc1_.OnOpenAward = this.ProcessorOpenAward;
            this.FGlobalbossChapter = this.FGlobalbossChapter.Next;
         }
      }
      
      protected function ProcessorOpenGlobalboss(param1:Object) : void
      {
         if(this.OnOpenGlobalboss != null)
         {
            this.OnOpenGlobalboss(param1);
         }
      }
      
      protected function ProcessorOpenAward(param1:TGlobalbossChapter) : void
      {
         this.FGlobalbossAward.SetData(param1);
         this.FGlobalbossAward.Visible = true;
      }
      
      protected function PerformPacket_CS_Chapter_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GlobalBoss_Chapter_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function OnCloseWindow(param1:MouseEvent) : void
      {
         ProcessorClose();
         if(this.OnOpenGlobalboss != null)
         {
            this.OnOpenGlobalboss();
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(param1 != null)
         {
            this.FGlobalbossLevel = param1.readUnsignedInt();
         }
         if(!FIsResourcesLoadCompleted)
         {
            this.FGlobalbossAward.Load();
            return;
         }
         this.PerformPacket_CS_Chapter_Req();
      }
   }
}

