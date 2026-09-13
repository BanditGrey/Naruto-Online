package Processors.Game.Lobby.TongLing
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.UI.TUICore;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TBB_Contract;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.TongLing.TTongLingDatas;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TongLing.ToolS.FiveCell;
   import Rendering.Overlayers.TongLingAnimal.TongLingAttriteTip;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TPressorTongLingBattle extends TProcessorLobbyWindow
   {
      
      private static const ATT_COUNT:int = 6;
      
      public static const NUMCELL:int = 5;
      
      protected var VecFiveCells:Vector.<FiveCell>;
      
      protected var FRootPanel:MovieClip = null;
      
      protected var FTipShop:TongLingAttriteTip;
      
      protected var FPerCompoent:TUIComponent;
      
      protected var FUcore:TUICore;
      
      public var OpenContion:int = 1;
      
      protected var VecPositions:Array;
      
      public var MC_Contract:MovieClip;
      
      protected var FTongLingDatas:TTongLingDatas;
      
      protected var FBmpVect:Vector.<Bitmap>;
      
      protected var FBarMaxWidth:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FOnShowHtmlTip:Function;
      
      protected var FOnHideHtmlTip:Function;
      
      public function TPressorTongLingBattle(param1:TUIComponent, param2:TUICore)
      {
         super(param1);
         this.FUcore = param2;
         this.FPerCompoent = param1;
         this.VecFiveCells = new Vector.<FiveCell>(NUMCELL);
         this.VecPositions = new Array();
         this.FTongLingDatas = SLogicsCore.TongLingDatas;
         this.FBmpVect = new Vector.<Bitmap>(4);
      }
      
      protected function OpenContract(param1:MouseEvent) : void
      {
         this.MC_Contract.visible = true;
         this.UpdateContract();
      }
      
      protected function HideContract(param1:MouseEvent) : void
      {
         this.MC_Contract.visible = false;
      }
      
      protected function OnUpgrade(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ContractUpgrade);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnUpgradeTen(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ContractUpgrade);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         var _loc3_:TBB_Status = null;
         if(Boolean(this.MC_Contract) && this.MC_Contract.visible)
         {
            _loc1_ = 1;
            while(_loc1_ <= 4)
            {
               _loc2_ = this.VecFiveCells[_loc1_].Curobj;
               if(_loc2_)
               {
                  _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,_loc2_.Id) as TBB_Status;
                  TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FBmpVect[_loc1_ - 1],CONST_MODULES.MODULE_TongLing,_loc3_.SmPic,1);
               }
               else
               {
                  this.FBmpVect[_loc1_ - 1].bitmapData = null;
               }
               _loc1_++;
            }
         }
      }
      
      public function seRoot(param1:MovieClip) : void
      {
         var _loc3_:FiveCell = null;
         var _loc5_:int = 0;
         var _loc6_:Bitmap = null;
         this.FRootPanel = param1;
         var _loc2_:int = 0;
         while(_loc2_ < NUMCELL)
         {
            _loc3_ = new FiveCell(this.FRootPanel["rabbit" + _loc2_]);
            this.VecPositions.push({
               "X":MovieClip(this.FRootPanel["rabbit" + _loc2_]).x,
               "Y":MovieClip(this.FRootPanel["rabbit" + _loc2_]).y
            });
            this.VecFiveCells[_loc2_] = _loc3_;
            this.VecFiveCells[_loc2_].OC = this.OCLick;
            this.VecFiveCells[_loc2_].MC = this.MCLick;
            this.VecFiveCells[_loc2_].TC = this.TCLick;
            _loc2_++;
         }
         var _loc4_:TBB_Contract = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Contract,this.FTongLingDatas.ContractID) as TBB_Contract;
         this.FRootPanel["TF_Rate"].text = _loc4_.Add / 10 + "%";
         this.VecFiveCells[0].IsVisibel_levelOpen = false;
         this.FTipShop = new TongLingAttriteTip(this.FPerCompoent);
         this.FTipShop.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTipShop);
         if(Boolean(this.FRootPanel["MC_Contract"]) && Boolean(this.FRootPanel["BTN_Contract"]))
         {
            this.MC_Contract = this.FRootPanel["MC_Contract"];
            this.FBmpVect.length = 0;
            _loc5_ = 1;
            while(_loc5_ <= 4)
            {
               _loc6_ = new Bitmap();
               this.MC_Contract["rabbit" + _loc5_]["mvc_pic"].addChild(_loc6_);
               this.FBmpVect.push(_loc6_);
               _loc5_++;
            }
            this.FMC_Mask = this.MC_Contract.MC_Bar.MC_Mask;
            this.FBarMaxWidth = this.FMC_Mask.width;
            this.MC_Contract.visible = false;
            this.MC_Contract["MC_Max"].visible = false;
            TGameUtil.setButtonMode(this.FRootPanel["BTN_Contract"],true);
            this.FRootPanel["BTN_Contract"].addEventListener(MouseEvent.CLICK,this.OpenContract);
            TGameUtil.setButtonMode(this.MC_Contract["BTN_Upgrade"],true);
            this.MC_Contract["BTN_Upgrade"].addEventListener(MouseEvent.CLICK,this.OnUpgrade);
            TGameUtil.setButtonMode(this.MC_Contract["BTN_UpgradeTen"],true);
            this.MC_Contract["BTN_UpgradeTen"].addEventListener(MouseEvent.CLICK,this.OnUpgradeTen);
            this.MC_Contract.BT_Close.addEventListener(MouseEvent.CLICK,this.HideContract);
            this.MC_Contract.Btn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.HelpOver);
            this.MC_Contract.Btn_Help.addEventListener(MouseEvent.ROLL_OUT,this.HelpOut);
         }
      }
      
      protected function OCLick(param1:Object) : void
      {
         var _loc2_:Object = {
            "id":param1.Id,
            "index":2,
            "level":param1.Level,
            "Identifier0":param1.Identifier0,
            "Identifier1":param1.Identifier1
         };
         this.FTipShop.Context = _loc2_;
         this.FTipShop.Render(this.FUcore.MouseCoordinate);
         this.FTipShop.Show();
      }
      
      protected function MCLick() : void
      {
         this.FTipShop.Render(this.FUcore.MouseCoordinate);
      }
      
      protected function TCLick() : void
      {
         this.FTipShop.Hide();
      }
      
      public function getFiveCellByIndex(param1:int) : FiveCell
      {
         return this.VecFiveCells[param1];
      }
      
      public function getFiveCellLength() : int
      {
         return this.VecFiveCells.length;
      }
      
      public function ChangePostion() : void
      {
         if(this.OpenContion)
         {
            MovieClip(this.FRootPanel["rabbit0"]).x = Object(this.VecPositions[0]).X;
            MovieClip(this.FRootPanel["rabbit0"]).y = Object(this.VecPositions[0]).Y;
            MovieClip(this.FRootPanel["rabbit4"]).x = Object(this.VecPositions[1]).X;
            MovieClip(this.FRootPanel["rabbit4"]).y = Object(this.VecPositions[1]).Y;
            MovieClip(this.FRootPanel["rabbit1"]).x = Object(this.VecPositions[2]).X;
            MovieClip(this.FRootPanel["rabbit1"]).y = Object(this.VecPositions[2]).Y;
            MovieClip(this.FRootPanel["rabbit2"]).x = Object(this.VecPositions[3]).X;
            MovieClip(this.FRootPanel["rabbit2"]).y = Object(this.VecPositions[3]).Y;
            MovieClip(this.FRootPanel["rabbit3"]).x = Object(this.VecPositions[4]).X;
            MovieClip(this.FRootPanel["rabbit3"]).y = Object(this.VecPositions[4]).Y;
            this.OpenContion = 0;
         }
      }
      
      public function UpdateContract() : void
      {
         var _loc1_:TBB_Contract = null;
         var _loc2_:TBB_Contract = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Contract,this.FTongLingDatas.ContractID) as TBB_Contract;
         if(this.FTongLingDatas.ContractID == 0)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Contract,10000001) as TBB_Contract;
         }
         else
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Contract,this.FTongLingDatas.ContractID + 1) as TBB_Contract;
         }
         this.MC_Contract.TF_Level.text = "LV" + _loc1_.Level;
         this.MC_Contract.TF_Add.text = _loc1_.Add / 10 + "%";
         this.MC_Contract.TF_Count.text = this.FTongLingDatas.ContractCount.toString();
         var _loc3_:int = 0;
         while(_loc3_ < ATT_COUNT)
         {
            this.MC_Contract["TF_Value" + _loc3_].text = String(this.FTongLingDatas.TongLingAtt[12 + _loc3_]);
            _loc3_++;
         }
         this.MC_Contract.TF_Exp.text = this.FTongLingDatas.CurExp + "/" + _loc1_.Exp;
         _loc4_ = Number(this.FTongLingDatas.CurExp / _loc1_.Exp) * this.FBarMaxWidth;
         _loc5_ = Math.min(_loc4_,this.FBarMaxWidth);
         this.FMC_Mask.width = _loc5_;
         if(!_loc2_)
         {
            this.MC_Contract["MC_Max"].visible = true;
            this.MC_Contract.TF_AddNext.text = " - ";
            return;
         }
         this.MC_Contract["MC_Max"].visible = false;
         this.MC_Contract.TF_AddNext.text = _loc2_.Add / 10 + "%";
         var _loc7_:int = this.PetInFight();
         _loc3_ = 0;
         while(_loc3_ < ATT_COUNT)
         {
            _loc6_ = this.FTongLingDatas.TongLingAtt[12 + _loc3_] * (_loc7_ + _loc2_.Add / 10) / (_loc1_.Add / 10 + _loc7_);
            this.MC_Contract["TF_Value0" + _loc3_].text = _loc6_.toString();
            _loc3_++;
         }
         TGameUtil.setButtonMode(this.MC_Contract["BTN_Upgrade"],this.FTongLingDatas.ContractCount >= 1);
         TGameUtil.setButtonMode(this.MC_Contract["BTN_UpgradeTen"],this.FTongLingDatas.ContractCount >= 10);
      }
      
      public function PetInFight() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.VecFiveCells.length)
         {
            if(this.VecFiveCells[_loc2_].Curobj)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_ == 2 ? 20 : (_loc1_ == 3 ? 25 : (_loc1_ == 4 ? 30 : 40));
      }
      
      public function PlayEffect() : void
      {
         if(this.MC_Contract)
         {
            this.MC_Contract.updateEffect.gotoAndPlay(1);
         }
      }
      
      public function get OnShowHtmlTip() : Function
      {
         return this.FOnShowHtmlTip;
      }
      
      public function set OnShowHtmlTip(param1:Function) : void
      {
         this.FOnShowHtmlTip = param1;
      }
      
      public function get OnHideHtmlTip() : Function
      {
         return this.FOnHideHtmlTip;
      }
      
      public function set OnHideHtmlTip(param1:Function) : void
      {
         this.FOnHideHtmlTip = param1;
      }
      
      protected function HelpOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FOnShowHtmlTip != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70170109) as TSystemLanguage;
            this.FOnShowHtmlTip(_loc2_.Desc);
         }
      }
      
      protected function HelpOut(param1:MouseEvent) : void
      {
         if(this.FOnHideHtmlTip != null)
         {
            this.FOnHideHtmlTip();
         }
      }
   }
}

