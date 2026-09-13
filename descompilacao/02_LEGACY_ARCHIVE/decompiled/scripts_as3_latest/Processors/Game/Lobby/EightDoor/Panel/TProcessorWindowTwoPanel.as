package Processors.Game.Lobby.EightDoor.Panel
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Tools.MvcPlayEffect;
   import Foundation.Utilities.TGameUtil;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TEightInnerGates_Obtain;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowTwoPanel
   {
      
      public static const THREE:int = 3;
      
      public static const FOUR:int = 4;
      
      public static const FIVE:int = 5;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FT_SilverCoin:TextField = null;
      
      protected var FT_Gold:TextField = null;
      
      protected var FT_Coupon:TextField = null;
      
      protected var FT_PropertyDec:TextField = null;
      
      protected var FMC_BuyBtn:MovieClip = null;
      
      protected var FTF_PiShanCishu:TextField = null;
      
      protected var FMC_Effect:MovieClip = null;
      
      protected var FMC_RoleEffect:MovieClip = null;
      
      protected var FIsInitilization:Boolean;
      
      protected var FCharacter:TCharacter;
      
      protected var FBaoXiangIdVec:Vector.<uint>;
      
      protected var FPiShanBtnFun:MovieClip = null;
      
      protected var FPiShanVec:Vector.<MovieClip>;
      
      protected var FFanBeiBtnFun:MovieClip = null;
      
      protected var FFanBeiVec:Vector.<MovieClip>;
      
      protected var FJianHaoJiuShou:MovieClip = null;
      
      protected var FRewardSlostVec:Vector.<MovieClip> = null;
      
      protected var FRewardDecSlostVec:Vector.<MovieClip> = null;
      
      protected var FMvcPlayEffect:MvcPlayEffect;
      
      protected var FMC_FourSlot:MovieClip = null;
      
      public var FCurFream:int = 4;
      
      protected var FBuyCount:Function;
      
      protected var FPiShanFun:Function;
      
      protected var FFanBeiFun:Function;
      
      protected var FBackOver:Function;
      
      protected var FBackOut:Function;
      
      protected var FBackMove:Function;
      
      protected var FBaoXiangOver:Function;
      
      protected var FBaoXiangOut:Function;
      
      protected var FBaoXiangMove:Function;
      
      public function TProcessorWindowTwoPanel()
      {
         super();
         this.FBaoXiangIdVec = new Vector.<uint>();
         this.FPiShanVec = new Vector.<MovieClip>(THREE);
         this.FFanBeiVec = new Vector.<MovieClip>(THREE);
         this.FRewardSlostVec = new Vector.<MovieClip>(FOUR);
         this.FRewardDecSlostVec = new Vector.<MovieClip>(FIVE);
      }
      
      public function set ThisPanel(param1:MovieClip) : void
      {
         var _loc2_:TSystemLanguage = null;
         var _loc3_:int = 0;
         this.FCharacter = SLogicsCore.Character;
         this.FThisPanel = param1;
         this.FT_SilverCoin = this.FThisPanel["TF_Silver"];
         this.FT_Gold = this.FThisPanel["TF_Gold"];
         this.FT_Coupon = this.FThisPanel["TF_GiftCertificate"];
         this.FT_PropertyDec = this.FThisPanel["TF_PropertyDec"];
         this.FMC_BuyBtn = this.FThisPanel["MC_BuyBtn"];
         this.FTF_PiShanCishu = this.FThisPanel["TF_PiShanCishu"];
         TGameUtil.setButtonMode(this.FMC_BuyBtn,true);
         this.FPiShanBtnFun = this.FThisPanel["MC_BtnFun_PiShan_"];
         this.FFanBeiBtnFun = this.FThisPanel["MC_BtnFun_FanBei"];
         this.FMC_Effect = this.FThisPanel["MC_Effect"];
         this.FMC_RoleEffect = this.FThisPanel["MC_RoleEffect"];
         this.FMC_FourSlot = this.FThisPanel["MC_FourSlot"];
         _loc3_ = 0;
         while(_loc3_ < THREE)
         {
            this.FPiShanVec[_loc3_] = this.FPiShanBtnFun["MC_Btn_" + _loc3_];
            SimpleButton(this.FPiShanVec[_loc3_]["MC_Btn"]).addEventListener(MouseEvent.CLICK,this.HandleClick);
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70295006 + _loc3_) as TSystemLanguage;
            TextField(this.FPiShanVec[_loc3_]["TF_Dec"]).text = _loc2_.Desc;
            this.FFanBeiVec[_loc3_] = this.FFanBeiBtnFun["MC_Btn_" + _loc3_];
            SimpleButton(this.FFanBeiVec[_loc3_]["MC_Btn"]).addEventListener(MouseEvent.CLICK,this.HandleClick);
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70295009 + _loc3_) as TSystemLanguage;
            TextField(this.FFanBeiVec[_loc3_]["TF_Dec"]).text = _loc2_.Desc;
            _loc3_++;
         }
         this.FJianHaoJiuShou = this.FThisPanel["MC_Btn_3"];
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70295009) as TSystemLanguage;
         TextField(this.FJianHaoJiuShou["TF_Dec"]).text = _loc2_.Desc;
         SimpleButton(this.FJianHaoJiuShou["MC_Btn"]).addEventListener(MouseEvent.CLICK,this.HandleClick);
         _loc3_ = 0;
         while(_loc3_ < FOUR)
         {
            this.FRewardSlostVec[_loc3_] = this.FMC_FourSlot["MC_TempSlot_" + _loc3_];
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < FIVE)
         {
            this.FRewardDecSlostVec[_loc3_] = this.FThisPanel["MC_DecReward_" + _loc3_];
            MovieClip(this.FRewardDecSlostVec[_loc3_]["MC_BaoXiang"]).gotoAndStop(_loc3_ + 1);
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70295001 + _loc3_) as TSystemLanguage;
            TextField(this.FRewardDecSlostVec[_loc3_]["MC_SlotDec"]).text = _loc2_.Desc;
            MovieClip(this.FRewardDecSlostVec[_loc3_]["MC_BaoXiang"]).addEventListener(MouseEvent.MOUSE_OVER,this.BaoXiangOver7);
            MovieClip(this.FRewardDecSlostVec[_loc3_]["MC_BaoXiang"]).addEventListener(MouseEvent.MOUSE_OUT,this.BaoXiangOut7);
            MovieClip(this.FRewardDecSlostVec[_loc3_]["MC_BaoXiang"]).addEventListener(MouseEvent.MOUSE_MOVE,this.BaoXiangMove7);
            _loc3_++;
         }
         this.AddListener();
         this.FIsInitilization = true;
      }
      
      protected function AddListener() : void
      {
         var _loc1_:int = 0;
         this.FMC_BuyBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         _loc1_ = 0;
         while(_loc1_ < FOUR)
         {
            this.FRewardSlostVec[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.HandelOver);
            this.FRewardSlostVec[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.HandelOut);
            this.FRewardSlostVec[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.HandelMove);
            _loc1_++;
         }
      }
      
      protected function BaoXiangOver7(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.currentTarget)
         {
            case this.FRewardDecSlostVec[0]["MC_BaoXiang"]:
               _loc2_ = 0;
               break;
            case this.FRewardDecSlostVec[1]["MC_BaoXiang"]:
               _loc2_ = 1;
               break;
            case this.FRewardDecSlostVec[2]["MC_BaoXiang"]:
               _loc2_ = 2;
               break;
            case this.FRewardDecSlostVec[3]["MC_BaoXiang"]:
               _loc2_ = 3;
               break;
            case this.FRewardDecSlostVec[4]["MC_BaoXiang"]:
               _loc2_ = 4;
         }
         if(this.FBaoXiangOver != null)
         {
            this.FBaoXiangOver(_loc2_);
         }
      }
      
      protected function BaoXiangOut7(param1:MouseEvent) : void
      {
         if(this.FBaoXiangOut != null)
         {
            this.FBaoXiangOut();
         }
      }
      
      protected function BaoXiangMove7(param1:MouseEvent) : void
      {
         if(this.FBaoXiangMove != null)
         {
            this.FBaoXiangMove();
         }
      }
      
      protected function HandelOver(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(_loc2_.length - 1));
         if(this.FBackOver != null)
         {
            this.FBackOver(_loc3_);
         }
      }
      
      protected function HandelOut(param1:MouseEvent) : void
      {
         if(this.FBackOut != null)
         {
            this.FBackOut();
         }
      }
      
      protected function HandelMove(param1:MouseEvent) : void
      {
         if(this.FBackMove != null)
         {
            this.FBackMove();
         }
      }
      
      public function UpdateView() : void
      {
         var _loc2_:int = 0;
         this.FTF_PiShanCishu.text = (SLogicsCore.EightDoorLogicData.EightDoorMoRenOpenCount + SLogicsCore.EightDoorLogicData.PiShanBuyCount - SLogicsCore.EightDoorLogicData.PiShanCount).toString();
         this.FPiShanBtnFun.visible = false;
         this.FFanBeiBtnFun.visible = false;
         this.FJianHaoJiuShou.visible = false;
         var _loc1_:TEightInnerGates_Obtain = null;
         switch(SLogicsCore.EightDoorLogicData.CurState)
         {
            case 0:
               this.FPiShanBtnFun.visible = true;
               break;
            case 1:
               this.FFanBeiBtnFun.visible = true;
               break;
            case 2:
               this.FJianHaoJiuShou.visible = true;
         }
         if(!this.FBaoXiangIdVec.length)
         {
            this.FMC_FourSlot.visible = false;
         }
         else
         {
            this.FMC_FourSlot.visible = true;
            _loc2_ = 0;
            while(_loc2_ < FOUR)
            {
               if(_loc2_ >= this.FBaoXiangIdVec.length)
               {
                  this.FRewardSlostVec[_loc2_].visible = false;
               }
               else
               {
                  this.FRewardSlostVec[_loc2_].visible = true;
                  _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EightInnerGates_Obtain,this.FBaoXiangIdVec[_loc2_]) as TEightInnerGates_Obtain;
                  MovieClip(this.FRewardSlostVec[_loc2_]["MC_BaoXiang"]).gotoAndStop(_loc1_.Quality);
               }
               _loc2_++;
            }
         }
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_BuyBtn:
               if(this.FBuyCount != null)
               {
                  this.FBuyCount();
               }
               break;
            case this.FFanBeiVec[0]["MC_Btn"]:
               this.FFanBeiFun(1);
               break;
            case this.FFanBeiVec[1]["MC_Btn"]:
               this.FFanBeiFun(2);
               break;
            case this.FFanBeiVec[2]["MC_Btn"]:
               this.FFanBeiFun(3);
               break;
            case this.FPiShanVec[0]["MC_Btn"]:
               this.FCurFream = 1;
               this.FPiShanFun(1);
               break;
            case this.FPiShanVec[1]["MC_Btn"]:
               this.FCurFream = 2;
               this.FPiShanFun(2);
               break;
            case this.FPiShanVec[2]["MC_Btn"]:
               this.FCurFream = 3;
               this.FPiShanFun(3);
               break;
            case this.FJianHaoJiuShou["MC_Btn"]:
               this.FFanBeiFun(1);
         }
      }
      
      public function PlayerEffect() : void
      {
         switch(SLogicsCore.EightDoorLogicData.CurState)
         {
            case 0:
               this.FCurFream = 4;
         }
         if(this.FCurFream != 4)
         {
            this.FMC_Effect.gotoAndPlay(1);
         }
         this.FMC_RoleEffect.gotoAndStop(this.FCurFream);
      }
      
      public function updateMoney() : void
      {
         if(!this.FIsInitilization)
         {
            return;
         }
         this.FT_SilverCoin.text = this.FCharacter.CreditSilverCoin.ToString();
         this.FT_Gold.text = this.FCharacter.CreditGold.toString();
         this.FT_Coupon.text = this.FCharacter.CreditGiftCertificate.toString();
         this.FT_PropertyDec.text = SLogicsCore.EightDoorLogicData.GodStoreCount.toString();
      }
      
      public function set FanBeiFun(param1:Function) : void
      {
         this.FFanBeiFun = param1;
      }
      
      public function set PiShanFun(param1:Function) : void
      {
         this.FPiShanFun = param1;
      }
      
      public function set BuyCount(param1:Function) : void
      {
         this.FBuyCount = param1;
      }
      
      public function get BaoXiangIdVec() : Vector.<uint>
      {
         return this.FBaoXiangIdVec;
      }
      
      public function set BackOver(param1:Function) : void
      {
         this.FBackOver = param1;
      }
      
      public function set BackOut(param1:Function) : void
      {
         this.FBackOut = param1;
      }
      
      public function set BackMove(param1:Function) : void
      {
         this.FBackMove = param1;
      }
      
      public function set BaoXiangOver(param1:Function) : void
      {
         this.FBaoXiangOver = param1;
      }
      
      public function set BaoXiangOut(param1:Function) : void
      {
         this.FBaoXiangOut = param1;
      }
      
      public function set BaoXiangMove(param1:Function) : void
      {
         this.FBaoXiangMove = param1;
      }
   }
}

