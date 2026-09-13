package Processors.Game.Lobby.Married.Panel
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import Processors.Game.Lobby.Married.TProcessorMarried;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class TUIMarriedDivorce extends TUIBaseWindow
   {
      
      private var _data:Object = null;
      
      public function TUIMarriedDivorce(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         FMC_Scene = param1;
         FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OVER,Parent["ButtonHelpOnOver"]);
         FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OUT,Parent["ButtonHelpOnOut"]);
         FMC_Scene["BTN_Close"].addEventListener(MouseEvent.CLICK,Parent["OnWindowClose"]);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Divorce,true);
         FMC_Scene.BTN_Divorce.addEventListener(MouseEvent.CLICK,this.onDivorceClick);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Cancel,true);
         FMC_Scene.BTN_Cancel.addEventListener(MouseEvent.CLICK,Parent["OnWindowClose"]);
         this.SetVisible(false);
      }
      
      override public function UpdateUI() : void
      {
         if(SLogicsCore.Character.NickName == THomelandModel.selfHome.username_0)
         {
            FMC_Scene.Text_Desc.text = TIllustratedModel.TextFormat(70480011,THomelandModel.selfHome.username_1);
         }
         else
         {
            FMC_Scene.Text_Desc.text = TIllustratedModel.TextFormat(70480011,THomelandModel.selfHome.username_0);
         }
      }
      
      private function onDivorceClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this.parent["Check"].Show(TIllustratedModel.TextFormat(70480038),function divorce():void
         {
            var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Married_DivorceReq);
            SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         },new Point(338,123));
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
         this.UpdateUI();
      }
      
      public function set Status(param1:int) : void
      {
         this.SetVisible(param1 == TProcessorMarried.DIVORCE);
      }
   }
}

