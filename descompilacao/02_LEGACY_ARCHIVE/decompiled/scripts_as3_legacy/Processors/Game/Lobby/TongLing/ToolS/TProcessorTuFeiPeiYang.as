package Processors.Game.Lobby.TongLing.ToolS
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TBB_AttriBute;
   import Logics.DatebaseVO.VO.TBB_Exp;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_TONGLINGANIMAL;
   import Resources.Strings.STRING_TONGLING;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorTuFeiPeiYang extends TProcessorLobbyWindow
   {
      
      public static const PetCount:int = 13;
      
      public static const FIVE:int = 6;
      
      public static const FOUR:int = 4;
      
      protected var FMainPanel:MovieClip;
      
      protected var FCloseBtn:SimpleButton;
      
      protected var FDateArr:Array = null;
      
      protected var FUIPage:TUIPage;
      
      protected var FUITabHeros:TUITab;
      
      protected var FHeroPageIndex:int;
      
      protected var FTabHeroIndex:int;
      
      protected var FCurTBB_Status:TBB_Status = null;
      
      protected var FCurBin:TBins = null;
      
      protected var FCurAtrrBin:TBins = null;
      
      protected var FCurBuyDate:TBins = null;
      
      protected var FCurObj:Object = null;
      
      protected var FHeadBmp:Bitmap = null;
      
      protected var FCurSlot:MovieClip = null;
      
      protected var FTF_ValueVec:Vector.<TextField> = null;
      
      protected var FTF_TextVec:Vector.<TextField> = null;
      
      protected var FActivity:Vector.<MovieClip> = null;
      
      protected var FCurPetName:TextField;
      
      protected var Flevel03:TextField = null;
      
      protected var FMC_ProgressBarExp0:MovieClip = null;
      
      protected var Fexp:TextField = null;
      
      protected var FTF_TuFeiStone:TextField = null;
      
      protected var FTF_NumCount:TextField = null;
      
      protected var FMC_MaxBtn:MovieClip = null;
      
      protected var FTF_HtmlText:TextField = null;
      
      protected var FMC_BuyBtn:MovieClip = null;
      
      protected var FMC_OneKeyTuFeiBtn:MovieClip = null;
      
      protected var FActivityValue:Vector.<Number> = null;
      
      protected var FActivityCostGold:Vector.<uint> = null;
      
      protected var FTuFeiId:uint;
      
      protected var FTuFeiExp:uint;
      
      protected var FGoldArr:Vector.<uint>;
      
      protected var FExpArr:Vector.<uint>;
      
      protected var FTF_TextVec1:Vector.<TextField>;
      
      protected var FMC_Right:MovieClip;
      
      protected var FMC_Left:MovieClip;
      
      protected var FDaoJuCount:uint;
      
      protected var FCurCount:uint;
      
      protected var FCurCostGold:uint = 0;
      
      protected var FCurBeiLv:Number = 0;
      
      protected var FLevelCopy:int;
      
      protected var FCurMaxLevel:int;
      
      protected var FCurExp:TBB_Exp;
      
      protected var FXiuLianLeiXing:int;
      
      protected var FBackFun:Function = null;
      
      protected var FBuyTuFei:Function;
      
      protected var FC_SFunc:Function = null;
      
      protected var FBack_Over:Function = null;
      
      protected var FBack_Out:Function = null;
      
      protected var FBack_Move:Function = null;
      
      public function TProcessorTuFeiPeiYang(param1:TUIComponent)
      {
         super(param1);
         this.FHeadBmp = new Bitmap();
         this.FUITabHeros = new TUITab(this);
         this.FUIPage = new TUIPage(this);
         this.FTF_ValueVec = new Vector.<TextField>(FIVE);
         this.FTF_TextVec = new Vector.<TextField>(FIVE);
         this.FActivity = new Vector.<MovieClip>(FOUR);
         this.FActivityValue = new Vector.<Number>(FOUR);
         this.FActivityCostGold = new Vector.<uint>(FOUR);
         this.FTF_TextVec1 = new Vector.<TextField>(3);
         this.FActivityValue[0] = 0;
         this.FActivityValue[1] = 1.2;
         this.FActivityValue[2] = 1.4;
         this.FActivityValue[3] = 1.8;
         this.FActivityCostGold[0] = 0;
         this.FActivityCostGold[1] = 200;
         this.FActivityCostGold[2] = 400;
         this.FActivityCostGold[3] = 800;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TONGLINGANIMAL.TONGLING_ID);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this.FMainPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_TuFeiPeiYang") as MovieClip;
         addChild(this.FMainPanel);
         this.FMainPanel.x = (FUICore.StageWidth - this.FMainPanel.width) / 2;
         this.FMainPanel.y = (FUICore.StageHeight - this.FMainPanel.height) / 2;
         this.FCloseBtn = this.FMainPanel[CONST_TONGLINGANIMAL.Select_Mod_close];
         _loc1_ = 0;
         while(_loc1_ < PetCount)
         {
            _loc2_ = this.FMainPanel["GeneralNameGroup"]["General_" + _loc1_];
            this.FUITabHeros.SetTabByIndex(_loc2_,_loc1_);
            this.FUITabHeros.SetTabCaptionByIndex("",_loc1_);
            _loc1_++;
         }
         this.FUITabHeros.OnSwitch = this.TabHerosOnSwitch;
         this.FUITabHeros.Init();
         this.FUIPage.ButtonPrevious.Substrate = this.FMainPanel["MC_HeroPage"]["MC_PageLeft"];
         this.FUIPage.ButtonNext.Substrate = this.FMainPanel["MC_HeroPage"]["MC_PageRight"];
         this.FUIPage.LabelPage = this.FMainPanel["MC_HeroPage"]["TF_Page"];
         TextField(this.FMainPanel["MC_HeroPage"]["TF_Page"]).text = "0/0";
         this.FUIPage.PageSize = PetCount;
         this.FUIPage.OnChangePage = this.HeroPageOnChange;
         this.FUIPage.Init();
         this.FCurSlot = this.FMainPanel["MC_Middle_Kuai"]["MC_Slot_0"];
         this.FCurSlot.buttonMode = true;
         this.FMC_Right = this.FMainPanel["MC_Right"];
         this.FMC_Left = this.FMainPanel["MC_Left"];
         MovieClip(this.FCurSlot["MC_Bmp_Icon"]).addChild(this.FHeadBmp);
         this.FCurPetName = this.FMainPanel["MC_Middle_Kuai"]["TF_AnimalName"];
         this.Flevel03 = this.FMainPanel["MC_Middle_Kuai"]["level03"];
         this.FMC_ProgressBarExp0 = this.FMainPanel["MC_Middle_Kuai"]["ExpItem"]["MC_ProgressBarExp0"];
         this.Fexp = this.FMainPanel["MC_Middle_Kuai"]["ExpItem"]["exp"];
         _loc1_ = 0;
         while(_loc1_ < FIVE)
         {
            this.FTF_ValueVec[_loc1_] = this.FMainPanel["MC_Middle_Kuai"]["TF_Value" + _loc1_];
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < FIVE)
         {
            this.FTF_TextVec[_loc1_] = this.FMainPanel["MC_Middle_Kuai"]["TF_Text" + _loc1_];
            _loc1_++;
         }
         this.FTF_TuFeiStone = this.FMainPanel["MC_Middle_Kuai"]["TF_TuFeiStone"];
         this.FTF_NumCount = this.FMainPanel["MC_Middle_Kuai"]["TF_NumCount"];
         this.FTF_NumCount.restrict = "0-9";
         this.FTF_NumCount.maxChars = 4;
         this.FMC_MaxBtn = this.FMainPanel["MC_Middle_Kuai"]["MC_MaxBtn"];
         TGameUtil.setButtonMode(this.FMC_MaxBtn,true);
         this.FTF_HtmlText = this.FMainPanel["MC_Middle_Kuai"]["TF_HtmlText"];
         _loc1_ = 0;
         while(_loc1_ < FOUR)
         {
            this.FActivity[_loc1_] = this.FMainPanel["MC_Middle_Kuai"]["Activity_" + _loc1_]["task"];
            if(_loc1_ != 0)
            {
               this.FTF_TextVec1[_loc1_ - 1] = this.FMainPanel["MC_Middle_Kuai"]["Activity_" + _loc1_]["TF_Text"];
            }
            _loc1_++;
         }
         this.FMC_BuyBtn = this.FMainPanel["MC_Middle_Kuai"]["MC_BuyBtn"];
         this.FMC_OneKeyTuFeiBtn = this.FMainPanel["MC_Middle_Kuai"]["MC_OneKeyTuFeiBtn"];
         TGameUtil.setButtonMode(this.FMC_BuyBtn,true);
         this.AddEventListener();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function GetJIshu() : int
      {
         var _loc1_:int = 0;
         this.FDaoJuCount = SLogicsCore.Character.Appliances.GetAllCountByTempletID(this.FTuFeiId);
         if(this.FDaoJuCount >= 1)
         {
            _loc1_ = 1;
         }
         else
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
      
      public function UpdateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBB_AttriBute = null;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:TBB_Exp = null;
         var _loc6_:int = 0;
         this.FDaoJuCount = SLogicsCore.Character.Appliances.GetAllCountByTempletID(this.FTuFeiId);
         this.FTF_TuFeiStone.text = this.FDaoJuCount.toString();
         if(this.FCurTBB_Status)
         {
            _loc2_ = null;
            _loc2_ = this.FCurAtrrBin.GetDatebaseByIdentifier(this.FCurTBB_Status.Identifier) as TBB_AttriBute;
            _loc3_ = _loc2_.LvArr[this.FCurObj.Level - 1];
            _loc3_ = _loc3_.substring(1,_loc3_.length - 1);
            _loc4_ = _loc3_.split(",");
            _loc1_ = 0;
            while(_loc1_ < FIVE)
            {
               this.FTF_ValueVec[_loc1_].text = _loc4_[_loc1_];
               _loc1_++;
            }
            this.FCurPetName.text = this.FCurTBB_Status.Name;
            this.FCurExp = this.FCurBin.GetDatebaseByIdentifier(this.FCurTBB_Status.Identifier) as TBB_Exp;
            this.FCurMaxLevel = this.GetaxLevel();
            this.Flevel03.text = TUtilityString.Format(STRING_TONGLING.TONGLING_86,this.FCurObj.Level);
            if(this.FCurObj.Level >= this.FCurMaxLevel)
            {
               this.FMC_ProgressBarExp0.visible = false;
               this.Fexp.visible = false;
               _loc1_ = 0;
               while(_loc1_ < FIVE)
               {
                  this.FTF_TextVec[_loc1_].text = "";
                  _loc1_++;
               }
               TGameUtil.setButtonMode(this.FMC_OneKeyTuFeiBtn,false);
            }
            else
            {
               _loc5_ = null;
               _loc5_ = this.FCurBin.GetDatebaseByIdentifier(this.FCurTBB_Status.Identifier) as TBB_Exp;
               _loc6_ = int(this.FCurObj.Level);
               this.Fexp.text = TUtilityString.Format(STRING_TONGLING.TONGLING_87,this.FCurObj.CurExp,_loc5_.LvArr[_loc6_]);
               this.FMC_ProgressBarExp0.visible = true;
               this.Fexp.visible = true;
               this.FMC_ProgressBarExp0.scaleX = this.FCurObj.CurExp / _loc5_.LvArr[_loc6_];
               TGameUtil.setButtonMode(this.FMC_OneKeyTuFeiBtn,true);
            }
            this.UpdateNewProperty();
         }
         else
         {
            this.FCurPetName.text = "";
            this.Flevel03.text = "";
            this.Fexp.text = "";
            this.FMC_ProgressBarExp0.visible = false;
            this.FTF_HtmlText.text = "";
            this.FTF_NumCount.text = "0";
            _loc1_ = 0;
            while(_loc1_ < FIVE)
            {
               this.FTF_ValueVec[_loc1_].text = "";
               this.FTF_TextVec[_loc1_].text = "";
               _loc1_++;
            }
            TGameUtil.setButtonMode(this.FMC_OneKeyTuFeiBtn,false);
         }
      }
      
      protected function TabHerosOnSwitch(param1:Object) : void
      {
         this.FTabHeroIndex = param1 as int;
         this.FTabHeroIndex += this.FHeroPageIndex * PetCount;
         this.FCurObj = this.FDateArr[this.FTabHeroIndex];
         this.FCurTBB_Status = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FCurObj.Id) as TBB_Status;
         this.FCurCount = this.GetJIshu();
         this.UpdateView();
      }
      
      protected function HeroPageOnChange(param1:Object, param2:int) : void
      {
         this.FHeroPageIndex = param2;
         this.FTabHeroIndex = 0;
         this.FTabHeroIndex += this.FHeroPageIndex * PetCount;
         this.FCurObj = this.FDateArr[this.FTabHeroIndex];
         this.FCurTBB_Status = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FCurObj.Id) as TBB_Status;
         this.UpdateTabs();
         this.FUITabHeros.SwithTagManual(0);
         this.UpdateView();
      }
      
      protected function UpdateTabs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TBB_Status = null;
         _loc2_ = int(this.FDateArr.length);
         _loc1_ = 0;
         while(_loc1_ < PetCount)
         {
            _loc5_ = _loc1_ + this.FHeroPageIndex * PetCount;
            if(_loc5_ >= _loc2_)
            {
               this.FUITabHeros.SetTabHideByIndex(_loc1_);
            }
            else
            {
               _loc3_ = this.FDateArr[_loc5_];
               _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,_loc3_.Id) as TBB_Status;
               _loc4_ = CONST_COMMON.QUALITYCOLOR_INDEX[_loc6_.Rarity];
               this.FUITabHeros.SetTabCaptionByIndex(_loc6_.Name,_loc1_,_loc4_);
               this.FUITabHeros.SetTabShowByIndex(_loc1_);
            }
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FDateArr = SLogicsCore.TongLingData;
         this.FCurBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BB_Exp);
         this.FCurAtrrBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BB_AttriBute);
         this.FCurBuyDate = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BB_BuyRapid);
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_TuFeiId) as TConfigValue;
         this.FTuFeiId = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_TuFeiBaseExp) as TConfigValue;
         this.FTuFeiExp = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_TuFeiarr1) as TConfigValue;
         this.FGoldArr = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_TuFeiarr2) as TConfigValue;
         this.FExpArr = _loc1_.Value as Vector.<uint>;
         super.ResourcesPerform_UILocations();
      }
      
      protected function AddEventListener() : void
      {
         var _loc1_:int = 0;
         this.FCloseBtn.addEventListener(MouseEvent.CLICK,this.ClickHandle);
         this.FMC_MaxBtn.addEventListener(MouseEvent.CLICK,this.ClickHandle);
         this.FTF_NumCount.addEventListener(Event.CHANGE,this.OnTextInput);
         _loc1_ = 0;
         while(_loc1_ < FOUR)
         {
            this.FActivity[_loc1_].buttonMode = true;
            this.FActivity[_loc1_].addEventListener(MouseEvent.CLICK,this.TaskHandle);
            _loc1_++;
         }
         this.FMC_BuyBtn.addEventListener(MouseEvent.CLICK,this.BtnreelClick);
         this.FMC_OneKeyTuFeiBtn.addEventListener(MouseEvent.CLICK,this.BtnreelClick);
         this.FCurSlot.addEventListener(MouseEvent.MOUSE_OVER,this.OverClickX);
         this.FCurSlot.addEventListener(MouseEvent.MOUSE_OUT,this.OutClickX);
         this.FCurSlot.addEventListener(MouseEvent.MOUSE_MOVE,this.MoveClickX);
      }
      
      protected function TaskHandle(param1:MouseEvent) : void
      {
         if(!this.FCurObj)
         {
            return;
         }
         switch(param1.currentTarget)
         {
            case this.FActivity[0]:
               this.SetTakState(0);
               break;
            case this.FActivity[1]:
               this.SetTakState(1);
               break;
            case this.FActivity[2]:
               this.SetTakState(2);
               break;
            case this.FActivity[3]:
               this.SetTakState(3);
         }
         this.UpdateNewProperty();
      }
      
      protected function SetTakState(param1:int) : void
      {
         var _loc2_:int = 0;
         this.FXiuLianLeiXing = param1;
         _loc2_ = 0;
         while(_loc2_ < FOUR)
         {
            this.FActivity[_loc2_].gotoAndStop(2);
            _loc2_++;
         }
         this.FActivity[param1].gotoAndStop(1);
         this.FCurBeiLv = this.FActivityValue[param1];
         this.FuckCao();
         this.UpdateGoldByCount();
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         this.FCurCount = int(this.FTF_NumCount.text) > this.GetJIshu() ? uint(int(this.FTF_NumCount.text)) : uint(this.GetJIshu());
         if(this.FCurCount > this.FDaoJuCount)
         {
            this.FCurCount = this.FDaoJuCount;
         }
         if(this.FCurCount <= this.GetJIshu())
         {
            this.FCurCount = this.GetJIshu();
         }
         if(!this.FCurTBB_Status)
         {
            return;
         }
         this.FuckCao();
         this.UpdateGoldByCount();
         this.UpdateNewProperty();
      }
      
      protected function UpdateGoldByCount() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = 0;
         if(this.FCurCount <= 0)
         {
            _loc2_ = 1;
         }
         else
         {
            _loc2_ = int(this.FCurCount);
         }
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_ = this.FExpArr[_loc1_] / 100 + 1;
            this.FTF_TextVec1[_loc1_].text = TUtilityString.Format(STRING_TONGLING.TONGLING_95[_loc1_],this.FGoldArr[_loc1_] * _loc2_,_loc3_);
            _loc1_++;
         }
         if(this.FXiuLianLeiXing)
         {
            this.FCurCostGold = this.FGoldArr[this.FXiuLianLeiXing - 1] * _loc2_;
         }
         else
         {
            this.FCurCostGold = 0;
         }
      }
      
      protected function FuckCao() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         this.FCurExp = this.FCurBin.GetDatebaseByIdentifier(this.FCurTBB_Status.Identifier) as TBB_Exp;
         _loc4_ = uint(this.FCurObj.Level);
         while(_loc4_ < this.FCurExp.LvArr.length)
         {
            _loc1_ += this.FCurExp.LvArr[_loc4_];
            _loc4_++;
         }
         if(this.FCurBeiLv == 0)
         {
            _loc2_ = 1;
         }
         else
         {
            _loc2_ = this.FCurBeiLv;
         }
         _loc3_ = this.FCurCount * this.FTuFeiExp * _loc2_;
         _loc1_ = _loc1_ + this.FTuFeiExp - this.FCurObj.CurExp;
         while(_loc3_ > _loc1_)
         {
            --this.FCurCount;
            _loc3_ = this.FCurCount * this.FTuFeiExp * _loc2_;
            if(_loc3_ < _loc1_ - this.FTuFeiExp)
            {
               ++this.FCurCount;
               break;
            }
         }
         if(this.FCurCount <= 0)
         {
            this.FCurCount = this.GetJIshu();
         }
      }
      
      protected function UpdateNewProperty() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         if(this.FCurBeiLv == 0)
         {
            _loc4_ = 1;
         }
         else
         {
            _loc4_ = this.FCurBeiLv;
         }
         _loc1_ = this.FCurCount * this.FTuFeiExp * _loc4_ + this.FCurObj.CurExp;
         this.FLevelCopy = this.FCurObj.Level;
         this.GetLevelBuExp(_loc1_,this.FCurExp.LvArr);
         var _loc5_:TBB_AttriBute = null;
         _loc5_ = this.FCurAtrrBin.GetDatebaseByIdentifier(this.FCurTBB_Status.Identifier) as TBB_AttriBute;
         var _loc6_:String = _loc5_.LvArr[this.FLevelCopy - 1];
         _loc6_ = _loc6_.substring(1,_loc6_.length - 1);
         while(_loc6_ == "")
         {
            --this.FLevelCopy;
            _loc6_ = _loc5_.LvArr[this.FLevelCopy - 1];
            _loc6_ = _loc6_.substring(1,_loc6_.length - 1);
         }
         var _loc7_:Array = _loc6_.split(",");
         _loc3_ = 0;
         while(_loc3_ < FIVE)
         {
            this.FTF_TextVec[_loc3_].text = _loc7_[_loc3_];
            _loc3_++;
         }
         if(this.FCurBeiLv <= 0)
         {
            _loc4_ = 0;
         }
         else
         {
            _loc4_ = this.FCurBeiLv - 1;
         }
         _loc4_ = this.FTuFeiExp * this.FCurCount * _loc4_;
         this.FTF_HtmlText.htmlText = TUtilityString.Format(STRING_TONGLING.TONGLING_88,this.FTuFeiExp * this.FCurCount,Math.ceil(_loc4_));
         this.FTF_NumCount.text = this.FCurCount.toString();
      }
      
      protected function GetaxLevel() : int
      {
         var _loc1_:* = int(this.FCurExp.LvArr.length);
         while(this.FCurExp.LvArr[_loc1_ - 1] == 0 && _loc1_ >= 0)
         {
            _loc1_--;
         }
         return _loc1_;
      }
      
      protected function GetLevelBuExp(param1:uint, param2:Array) : void
      {
         var _loc3_:int = 0;
         if(this.FLevelCopy >= this.FCurMaxLevel)
         {
            return;
         }
         if(param1 >= param2[this.FLevelCopy] && this.FLevelCopy <= this.FCurMaxLevel)
         {
            ++this.FLevelCopy;
            this.GetLevelBuExp(param1 - param2[this.FLevelCopy - 1],param2);
            return;
         }
      }
      
      public function OpenThisPanel() : void
      {
         this.FHeroPageIndex = 0;
         this.FTabHeroIndex = 0;
         this.FMC_Right.gotoAndPlay(1);
         this.FMC_Left.gotoAndPlay(1);
         this.FCurCount = this.GetJIshu();
         if(this.FDateArr.length)
         {
            this.FCurObj = this.FDateArr[this.FTabHeroIndex];
            this.FCurTBB_Status = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FCurObj.Id) as TBB_Status;
         }
         else
         {
            this.FCurObj = null;
            this.FCurTBB_Status = null;
         }
         this.UpdateTabs();
         this.UpdateHeroUIPage();
         this.SetTakState(0);
         this.FUITabHeros.SwithTagManual(0);
         this.UpdateGoldByCount();
         this.UpdateView();
      }
      
      public function UpdatePanelImage() : void
      {
         if(this.FCurTBB_Status)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FHeadBmp,CONST_MODULES.MODULE_TongLing,this.FCurTBB_Status.SmPic);
         }
      }
      
      protected function ClickHandle(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FCloseBtn:
               if(this.FBackFun != null)
               {
                  this.FBackFun();
               }
               break;
            case this.FMC_MaxBtn:
               if(!this.FCurObj)
               {
                  return;
               }
               this.FCurCount = this.FDaoJuCount;
               this.FuckCao();
               this.UpdateGoldByCount();
               this.UpdateNewProperty();
         }
      }
      
      public function UpdateHeroUIPage() : void
      {
         this.FUIPage.TotalQuantity = this.FDateArr.length;
         this.FUIPage.PageIndex = this.FHeroPageIndex;
         this.FUIPage.Update();
      }
      
      public function OverClickX(param1:MouseEvent) : void
      {
         if(!this.FCurObj)
         {
            return;
         }
         if(this.FBack_Over != null)
         {
            this.FBack_Over(this.FCurObj,true,false);
         }
      }
      
      public function OutClickX(param1:MouseEvent) : void
      {
         if(!this.FCurObj)
         {
            return;
         }
         if(this.FBack_Out != null)
         {
            this.FBack_Out(this.FCurObj,true,false);
         }
      }
      
      public function MoveClickX(param1:MouseEvent) : void
      {
         if(!this.FCurObj)
         {
            return;
         }
         if(this.FBack_Move != null)
         {
            this.FBack_Move(this.FCurObj,false);
         }
      }
      
      public function BtnreelClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_OneKeyTuFeiBtn:
               if(this.FCurCount <= 0 || !this.FMC_OneKeyTuFeiBtn.buttonMode)
               {
                  return;
               }
               this.FC_SFunc(this.FCurObj,this.FCurCount,this.FXiuLianLeiXing,this.FCurCostGold);
               break;
            case this.FMC_BuyBtn:
               this.FBuyTuFei(100001,1);
         }
      }
      
      public function set Back_Out(param1:Function) : void
      {
         this.FBack_Out = param1;
      }
      
      public function set Back_Over(param1:Function) : void
      {
         this.FBack_Over = param1;
      }
      
      public function set Back_Move(param1:Function) : void
      {
         this.FBack_Move = param1;
      }
      
      public function set C_SFunc(param1:Function) : void
      {
         this.FC_SFunc = param1;
      }
      
      public function set BuyTuFei(param1:Function) : void
      {
         this.FBuyTuFei = param1;
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
   }
}

