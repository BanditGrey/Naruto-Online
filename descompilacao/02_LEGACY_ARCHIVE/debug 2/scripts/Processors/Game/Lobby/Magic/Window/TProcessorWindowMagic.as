package Processors.Game.Lobby.Magic.Window
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TMewBattle;
   import Logics.DatebaseVO.VO.TMewMagic;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Magic.TMagic;
   import Logics.Magic.TMagicData;
   import Logics.Magic.TMagics;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Editors.TUIWindowEditor;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MAGIC;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_MAGIC;
   import Resources.Strings.STRING_NINJIAREINCARNATION;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowMagic extends TProcessorWindowTemplate
   {
      
      protected const CAPACITY_MC_MAGICS:uint = 4;
      
      protected const CAPACITY_TF_Atrributes:uint = 8;
      
      protected const WIDTH_ProgressBar:uint = 313;
      
      protected var FMagicVec:Vector.<MovieClip>;
      
      protected var FTF_PromoteEffect:TextField;
      
      protected var FMC_MagicBigIcon:MovieClip;
      
      protected var FTF_MagicName:TextField;
      
      protected var FTF_UnlockExplanation:TextField;
      
      protected var FTF_MagicLevel:TextField;
      
      protected var FTF_Experience:TextField;
      
      protected var FMC_ProgressBarExp:MovieClip;
      
      protected var FMC_CurrentAttributes:TextField;
      
      protected var FMC_PointAttributes:TextField;
      
      protected var FMC_SilverPractice:MovieClip;
      
      protected var FMC_GoldPractice:MovieClip;
      
      protected var FMC_AdvancedPractice:MovieClip;
      
      protected var FTF_TodayRestCount:TextField;
      
      protected var FTF_NaturePoints:TextField;
      
      protected var FBTN_GotoMoutain:MovieClip;
      
      protected var FBTN_ItemPractice:MovieClip;
      
      protected var FBTN_ItemPracticeCopy:MovieClip;
      
      protected var FTF_BaoJiText:TextField;
      
      protected var FMagicData:TMagicData;
      
      protected var FMagic:TMagic;
      
      protected var FIndex:int;
      
      protected var FTF_Attributes:Vector.<TextField>;
      
      protected var FLimitCount:uint;
      
      protected var FCharacter:TCharacter;
      
      protected var FCostGold:uint;
      
      protected var FUIWindowAdvancedPractice:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FUIWindowEditor:TUIWindowEditor;
      
      protected var FGoldPracticeCount:uint;
      
      protected var FCostGoldArr:Vector.<uint>;
      
      protected var FCostGoldArrCopy:Vector.<uint>;
      
      protected var FHint:THint;
      
      protected var FPracticeTimes:uint;
      
      protected var FIsOpenGold:Boolean;
      
      protected var FIsOpenAdvanced:Boolean;
      
      protected var FCurPracticeBtn:MovieClip;
      
      protected var FScrollBar:TScrollBar = null;
      
      protected var FMC_Price_Middle:MovieClip = null;
      
      protected var FOnPracticeClick:Function;
      
      protected var FOnEnterMoutain:Function;
      
      protected var FUIHintOnOver:Function;
      
      protected var FUIHintOnOut:Function;
      
      public function TProcessorWindowMagic(param1:TUIComponent)
      {
         super(param1);
         this.FMagicVec = new Vector.<MovieClip>(this.CAPACITY_MC_MAGICS);
         this.FTF_Attributes = new Vector.<TextField>(this.CAPACITY_TF_Atrributes);
         this.FHint = new THint();
         this.FCharacter = SLogicsCore.Character;
         this.FCostGold = 0;
         this.FIsOpenGold = true;
         this.FIsOpenAdvanced = true;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_MAGIC.RESOURCESID_Swf_Magic);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_MAGIC.RESOURCE_ClassName_MC_Magic) as Sprite;
         UIDispatch();
         this.FMC_Price_Middle = FMainUI["MC_Price_Middle"];
         this.FScrollBar = new TScrollBar(FMainUI["MC_List"],302,true,0,0,true);
         this.FScrollBar.Clear();
         this.FScrollBar.AddItem(this.FMC_Price_Middle);
         this.FScrollBar.ScrollToUp();
         _loc2_ = this.CAPACITY_MC_MAGICS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_Price_Middle["MC_Magic_" + _loc1_];
            this.FMagicVec[_loc1_] = _loc3_;
            _loc3_["MC_MagicIcon"].gotoAndStop(_loc1_ + 1);
            _loc3_["MC_Select"].visible = false;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_TF_Atrributes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTF_Attributes[_loc1_] = FMainUI["TF_Atrribute_" + _loc1_];
            this.FTF_Attributes[_loc1_].text = "";
            _loc1_++;
         }
         this.FTF_PromoteEffect = FMainUI["TF_PromoteEffect"];
         this.FMC_MagicBigIcon = FMainUI["MC_MagicBigIcon"];
         this.FTF_MagicName = this.FMC_MagicBigIcon["MC_Name"]["TF_Name"];
         this.FTF_UnlockExplanation = FMainUI["TF_UnlockExplanation"];
         this.FTF_MagicLevel = FMainUI["MC_Experience"]["TF_MagicLevel"];
         this.FTF_Experience = FMainUI["MC_Experience"]["TF_Experience"];
         this.FMC_ProgressBarExp = FMainUI["MC_Experience"]["MC_ProgressBarExp"];
         this.FMC_CurrentAttributes = FMainUI["MC_CurrentAttributes"];
         this.FMC_PointAttributes = FMainUI["MC_PointAttributes"];
         this.FMC_SilverPractice = FMainUI["MC_SilverPractice"];
         TGameUtil.setButtonMode(this.FMC_SilverPractice,true);
         this.FMC_GoldPractice = FMainUI["MC_GoldPractice"];
         TGameUtil.setButtonMode(this.FMC_GoldPractice,true);
         this.FMC_AdvancedPractice = FMainUI["MC_AdvancedPractice"];
         TGameUtil.setButtonMode(this.FMC_AdvancedPractice,true);
         this.FTF_TodayRestCount = FMainUI["TF_TodayRestCount"];
         this.FTF_NaturePoints = FMainUI["TF_NaturePoints"];
         this.FBTN_GotoMoutain = FMainUI["BTN_GotoMoutain"];
         TGameUtil.setButtonMode(this.FBTN_GotoMoutain,true);
         this.FBTN_ItemPractice = FMainUI["BTN_ItemPractice"];
         TGameUtil.setButtonMode(this.FBTN_ItemPractice,true);
         this.FBTN_ItemPracticeCopy = FMainUI["BTN_ItemPracticeCopy"];
         TGameUtil.setButtonMode(this.FBTN_ItemPracticeCopy,true);
         this.FTF_BaoJiText = FMainUI["TF_BaoJiText"];
         this.FUIWindowAdvancedPractice = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowAdvancedPractice.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowAdvancedPractice.x = (STAGE_Width - this.FUIWindowAdvancedPractice.WindowWidth) / 2;
         this.FUIWindowAdvancedPractice.y = (STAGE_Height - this.FUIWindowAdvancedPractice.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowAdvancedPractice);
         this.FUIWindowAdvancedPractice.SetCheckBox(true);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FUIWindowEditor = new TUIWindowEditor(this.Parent,CONST_MODULES.MODULE_Magic);
         this.FUIWindowEditor.OnOK = this.WindowEditorOnOK;
         this.FUIWindowEditor.OnCancel = this.WindowEditorOnCancel;
         this.FUIWindowEditor.OnMax = this.WindowEditorOnMax;
         this.FUIWindowEditor.x = (STAGE_Width - this.FUIWindowEditor.WindowWidth) / 2;
         this.FUIWindowEditor.y = (STAGE_Height - this.FUIWindowEditor.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowEditor(this.FUIWindowEditor);
         if(!SLogicsCore.Character.GetConfigValueById(91000010))
         {
            this.FMagicVec[3].visible = false;
            this.FScrollBar.SetScrollVisble(false);
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TSystemLanguage = null;
         UILocations();
         _loc2_ = this.CAPACITY_MC_MAGICS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMagicVec[_loc1_];
            _loc3_.addEventListener(MouseEvent.CLICK,this.MC_MagicOnClick,false,0,true);
            _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.MC_MagicOnOver,false,0,true);
            _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.MC_MagicOnOut,false,0,true);
            _loc1_++;
         }
         this.FMC_SilverPractice.addEventListener(MouseEvent.CLICK,this.SilverPracticeOnClick,false,0,true);
         this.FMC_SilverPractice.addEventListener(MouseEvent.MOUSE_MOVE,this.PracticeOnOver,false,0,true);
         this.FMC_SilverPractice.addEventListener(MouseEvent.ROLL_OUT,this.PracticeOnOut,false,0,true);
         this.FMC_GoldPractice.addEventListener(MouseEvent.CLICK,this.GoldPracticeOnClick,false,0,true);
         this.FMC_GoldPractice.addEventListener(MouseEvent.MOUSE_MOVE,this.PracticeOnOver,false,0,true);
         this.FMC_GoldPractice.addEventListener(MouseEvent.ROLL_OUT,this.PracticeOnOut,false,0,true);
         this.FMC_AdvancedPractice.addEventListener(MouseEvent.CLICK,this.AdvancedPracticeOnClick,false,0,true);
         this.FMC_AdvancedPractice.addEventListener(MouseEvent.MOUSE_MOVE,this.PracticeOnOver,false,0,true);
         this.FMC_AdvancedPractice.addEventListener(MouseEvent.ROLL_OUT,this.PracticeOnOut,false,0,true);
         this.FBTN_ItemPractice.addEventListener(MouseEvent.CLICK,this.ItemPracticeOnClick,false,0,true);
         this.FBTN_ItemPractice.addEventListener(MouseEvent.MOUSE_MOVE,this.PracticeOnOver,false,0,true);
         this.FBTN_ItemPractice.addEventListener(MouseEvent.ROLL_OUT,this.PracticeOnOut,false,0,true);
         this.FBTN_ItemPracticeCopy.addEventListener(MouseEvent.CLICK,this.ItemPracticeOnClick,false,0,true);
         this.FBTN_ItemPracticeCopy.addEventListener(MouseEvent.MOUSE_MOVE,this.PracticeOnOver,false,0,true);
         this.FBTN_ItemPracticeCopy.addEventListener(MouseEvent.ROLL_OUT,this.PracticeOnOut,false,0,true);
         this.FTF_NaturePoints.addEventListener(MouseEvent.MOUSE_MOVE,this.NaturePointsOnOver,false,0,true);
         this.FTF_NaturePoints.addEventListener(MouseEvent.ROLL_OUT,this.NaturePointsOnOut,false,0,true);
         this.FBTN_GotoMoutain.addEventListener(MouseEvent.CLICK,this.GotoMoutainOnClick,false,0,true);
         this.FLimitCount = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Mew_Silver_number) as TConfigValue).Value as uint;
         this.FGoldPracticeCount = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Mew_High_Gold) as TConfigValue).Value as uint;
         var _loc5_:TConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Mew_Need_Gold) as TConfigValue;
         this.FCostGoldArr = _loc5_.Value as Vector.<uint>;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Mew_Cao_Gold) as TConfigValue;
         this.FCostGoldArrCopy = _loc5_.Value as Vector.<uint>;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.Mew_Magic_Tips) as TSystemLanguage;
         FHelpTips.Content = _loc4_.Desc;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!Visible)
         {
            return;
         }
         if(this.FUIWindowEditor.Visible)
         {
            this.FUIWindowEditor.Update();
         }
      }
      
      protected function DefaultSelect() : void
      {
         this.MC_MagicOnClick(null);
      }
      
      protected function UpdateRightInfo() : void
      {
         this.UpdateMagicBigIcon();
         this.UpdateAtrribute();
         this.UpdateExperience();
      }
      
      protected function UpdateMagicBigIcon() : void
      {
         this.FTF_PromoteEffect.text = STRING_MAGIC.STRING_MagicEffect[this.FIndex];
         this.FMC_MagicBigIcon.gotoAndStop(this.FIndex + 1);
         this.FTF_MagicName.text = this.FMagic.MagicName;
         if(this.FIndex == 3)
         {
            this.FBTN_ItemPracticeCopy.visible = true;
            this.FBTN_ItemPractice.visible = false;
         }
         else
         {
            this.FBTN_ItemPracticeCopy.visible = false;
            this.FBTN_ItemPractice.visible = true;
         }
      }
      
      protected function UpdateAtrribute() : void
      {
         var _loc1_:TAppliance = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TextField = null;
         var _loc5_:TMewMagic = null;
         var _loc6_:int = 0;
         var _loc7_:TInventories = null;
         var _loc8_:uint = 0;
         var _loc9_:TInventory = null;
         var _loc10_:uint = 0;
         _loc7_ = SLogicsCore.Character.Appliances;
         if(this.FIndex == 3)
         {
            _loc10_ = 14111270;
         }
         else
         {
            _loc10_ = 14107003;
         }
         _loc1_ = _loc7_.GetInventoryByTempletID(_loc10_) as TAppliance;
         _loc8_ = 0;
         if(_loc1_ != null)
         {
            _loc3_ = uint(_loc7_.Count);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc9_ = _loc7_.GetInventoryByIndex(_loc2_);
               if(_loc9_.CategorySecond == _loc1_.CategorySecond)
               {
                  _loc8_ += _loc9_.Quantity;
               }
               _loc2_++;
            }
         }
         this.FTF_NaturePoints.text = _loc8_.toString();
         this.FTF_TodayRestCount.text = TUtilityString.Format(STRING_MAGIC.FORMAT_RestCount,this.FMagicData.SilverPracticeCount,this.FLimitCount);
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_MewMagic,this.FMagic.Nextid) as TMewMagic;
         _loc3_ = this.CAPACITY_TF_Atrributes;
         _loc6_ = this.CAPACITY_TF_Atrributes / 2;
         if(_loc5_ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = this.FTF_Attributes[_loc2_];
               if(_loc2_ < _loc6_)
               {
                  _loc4_.text = this.FMagic.Atrributes[_loc2_].toString();
               }
               else
               {
                  _loc4_.text = _loc5_.Atrributes[_loc2_ - _loc6_].toString();
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = this.FTF_Attributes[_loc2_];
               if(_loc2_ < _loc6_)
               {
                  _loc4_.text = this.FMagic.Atrributes[_loc2_].toString();
               }
               else
               {
                  _loc4_.text = "";
               }
               _loc2_++;
            }
         }
      }
      
      protected function UpdateExperience() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:TMewBattle = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc8_:String = null;
         var _loc7_:String = "";
         _loc3_ = this.FMagicData.StageID;
         _loc1_ = _loc3_ < this.FMagic.NeedBlock;
         this.FTF_UnlockExplanation.visible = _loc1_;
         if(_loc1_)
         {
            _loc2_ = this.FMagicData.MagicLevels.GetMagicLevelByIdentifier(this.FMagic.NeedBlock);
            if(this.FMagic.Level == 0)
            {
               _loc6_ = this.FMagic.Level + 1;
            }
            else
            {
               _loc6_ = this.FMagic.Level;
            }
            if(this.FMagic.NeedReincarnationLevel == 0)
            {
               _loc7_ = _loc6_.toString();
               _loc8_ = STRING_MAGIC.FORMAT_PassOpen;
            }
            else
            {
               _loc7_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,this.FMagic.NeedReincarnationLevel,_loc6_);
               _loc8_ = STRING_MAGIC.FORMAT_PassOpenCopy;
            }
            this.FTF_UnlockExplanation.text = TUtilityString.Format(_loc8_,STRING_MAGIC.STRING_Levels[_loc2_.Location],STRING_MAGIC.STRING_ChineseNum[(this.FMagic.NeedBlock - 1) % 100 % 3],_loc7_);
         }
         _loc6_ = this.FMagic.Level;
         if(this.FMagic.NeedReincarnationLevel == 0)
         {
            _loc7_ = STRING_COMMON.FORMAT_Level + _loc6_.toString();
         }
         else
         {
            _loc7_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.Reincarnation_Describe,this.FMagic.NeedReincarnationLevel,_loc6_);
         }
         this.FTF_MagicLevel.text = _loc7_;
         _loc4_ = int(this.FMagic.CurExp);
         _loc5_ = this.FMagic.NeedExp;
         if(_loc5_ <= 0)
         {
            _loc4_ = 0;
            _loc5_ = 0;
         }
         this.FTF_Experience.text = TUtilityString.Format(STRING_MAGIC.FORMAT_Experience,_loc4_,_loc5_);
         this.FMC_ProgressBarExp.width = _loc4_ == 0 ? 0 : this.WIDTH_ProgressBar * this.FMagic.CurExp / this.FMagic.NeedExp;
         this.UpdateCountDec();
      }
      
      protected function CheckCost() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc7_:Vector.<uint> = null;
         if(this.FIndex == 3)
         {
            _loc7_ = this.FCostGoldArrCopy;
         }
         else
         {
            _loc7_ = this.FCostGoldArr;
         }
         this.FCostGold = 0;
         _loc5_ = int(this.FMagic.GoldPracticeCount);
         _loc4_ = _loc7_.length;
         _loc2_ = this.FGoldPracticeCount;
         if(_loc5_ >= _loc4_)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FCostGold += _loc7_[_loc4_ - 1];
               _loc1_++;
            }
         }
         else
         {
            _loc6_ = 0;
            _loc3_ = _loc1_ + _loc5_;
            while(_loc3_ < _loc4_)
            {
               if(++_loc6_ > 20)
               {
                  break;
               }
               this.FCostGold += _loc7_[_loc3_];
               _loc3_++;
            }
            if(_loc6_ < this.FGoldPracticeCount)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc2_ - _loc6_)
               {
                  this.FCostGold += _loc7_[_loc4_ - 1];
                  _loc1_++;
               }
            }
         }
      }
      
      protected function MC_MagicOnClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc6_:TMagic = null;
         var _loc7_:TMagics = null;
         if(param1 != null)
         {
            _loc2_ = param1.currentTarget as MovieClip;
         }
         else
         {
            _loc2_ = this.FMagicVec[0];
         }
         this.FIndex = _loc2_.name.split("_")[2];
         _loc7_ = this.FMagicData.Magics;
         if(_loc7_.Count > 0)
         {
            this.FMagic = _loc7_.GetMagicByIndex(this.FIndex);
         }
         _loc4_ = this.CAPACITY_MC_MAGICS;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc2_ == this.FMagicVec[_loc3_];
            _loc6_ = _loc7_.GetMagicByIndex(_loc3_);
            if(_loc6_ != null)
            {
               this.FMagicVec[_loc3_]["TF_MagicName"].text = _loc6_.MagicName;
               this.FMagicVec[_loc3_]["MC_Select"].visible = _loc5_;
            }
            _loc3_++;
         }
         this.UpdateRightInfo();
      }
      
      protected function MC_MagicOnOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc2_.gotoAndStop(2);
      }
      
      protected function MC_MagicOnOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc2_.gotoAndStop(1);
      }
      
      protected function SilverPracticeOnClick(param1:MouseEvent) : void
      {
         if(this.FOnPracticeClick != null)
         {
            this.FOnPracticeClick(this,this.FIndex,CONST_MAGIC.TYPE_SilverPractice,1);
         }
      }
      
      protected function PracticeOnOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:MovieClip = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:Vector.<uint> = null;
         _loc4_ = param1.currentTarget as MovieClip;
         _loc3_ = _loc4_.name;
         if(this.FMagic == null)
         {
            return;
         }
         if(_loc3_ == "MC_SilverPractice")
         {
            _loc5_ = this.FLimitCount - this.FMagicData.SilverPracticeCount;
            if(_loc5_ > 0)
            {
               _loc2_ = TUtilityString.Format(STRING_MAGIC.FORMAT_SilverCost,this.FMagic.NeedSilver,this.FMagic.SilverExp,_loc5_);
            }
            else
            {
               _loc2_ = STRING_MAGIC.FORMAT_SilverUseOut;
            }
         }
         else if(_loc3_ == "MC_GoldPractice")
         {
            if(this.FIndex == 3)
            {
               _loc7_ = this.FCostGoldArrCopy;
            }
            else
            {
               _loc7_ = this.FCostGoldArr;
            }
            if(this.FMagic.GoldPracticeCount >= _loc7_.length)
            {
               _loc6_ = _loc7_.length - 1;
            }
            else
            {
               _loc6_ = int(this.FMagic.GoldPracticeCount);
            }
            _loc2_ = TUtilityString.Format(STRING_MAGIC.FORMAT_GoldCost,_loc7_[_loc6_] + this.FMagic.NeedGold,this.FMagic.GoldExp);
         }
         else if(_loc3_ == "BTN_ItemPractice")
         {
            _loc2_ = TUtilityString.Format(STRING_MAGIC.FORMAT_ItemCost,this.FMagic.NeedItem,this.FMagic.ItemExp);
         }
         else if(_loc3_ == "MC_AdvancedPractice")
         {
            this.CheckCost();
            _loc2_ = TUtilityString.Format(STRING_MAGIC.FORMAT_AdvancedCost,this.FCostGold,this.FGoldPracticeCount);
         }
         else if(_loc3_ == "BTN_ItemPracticeCopy")
         {
            _loc2_ = TUtilityString.Format(STRING_MAGIC.FORMAT_ItemCostCopy,this.FMagic.NeedItem,this.FMagic.ItemExp);
         }
         this.FHint.Caption = _loc2_;
         if(this.FUIHintOnOver != null)
         {
            this.FUIHintOnOver(this,this.FHint);
         }
      }
      
      protected function PracticeOnOut(param1:MouseEvent) : void
      {
         if(this.FUIHintOnOut != null)
         {
            this.FUIHintOnOut(this);
         }
      }
      
      protected function NaturePointsOnOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:TArticle = null;
         var _loc4_:uint = 0;
         if(this.FIndex == 3)
         {
            _loc4_ = 14111270;
         }
         else
         {
            _loc4_ = 14107003;
         }
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc4_) as TArticle;
         _loc2_ = _loc3_.FunctionDesc;
         this.FHint.Caption = _loc2_;
         if(this.FUIHintOnOver != null)
         {
            this.FUIHintOnOver(this,this.FHint);
         }
      }
      
      protected function NaturePointsOnOut(param1:MouseEvent) : void
      {
         if(this.FUIHintOnOut != null)
         {
            this.FUIHintOnOut(this);
         }
      }
      
      protected function UpdateCountDec() : void
      {
         var _loc1_:int = 0;
         _loc1_ = int(this.FMagic.GoldPracticeCount);
         if(_loc1_ >= 10)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc1_ = 10 - _loc1_;
         }
         this.FTF_BaoJiText.text = TUtilityString.Format(STRING_MAGIC.BaoJiDec,_loc1_);
      }
      
      protected function GoldPracticeOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<uint> = null;
         if(this.FIndex == 3)
         {
            _loc3_ = this.FCostGoldArrCopy;
         }
         else
         {
            _loc3_ = this.FCostGoldArr;
         }
         this.FCurPracticeBtn = param1.currentTarget as MovieClip;
         if(this.FMagic.GoldPracticeCount >= _loc3_.length)
         {
            _loc2_ = _loc3_.length - 1;
         }
         else
         {
            _loc2_ = int(this.FMagic.GoldPracticeCount);
         }
         this.FCostGold = _loc3_[_loc2_] + this.FMagic.NeedGold;
         if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < this.FCostGold)
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         if(this.FIsOpenGold)
         {
            this.FUIWindowAdvancedPractice.IsSelected = false;
            this.FUIWindowAdvancedPractice.SetSelectedOrNot(false);
         }
         else
         {
            this.FUIWindowAdvancedPractice.IsSelected = true;
         }
         if(!this.FUIWindowAdvancedPractice.IsSelected)
         {
            this.FPracticeTimes = 1;
            if(this.FMagic.GoldPracticeCount >= _loc3_.length)
            {
               this.FMagic.GoldPracticeCount = _loc3_.length - 1;
            }
            this.FUIWindowAdvancedPractice.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Magic_Practice).DescribeString,_loc3_[this.FMagic.GoldPracticeCount]);
            this.FUIWindowAdvancedPractice.SetCheckBox(true);
            this.FUIWindowAdvancedPractice.Visible = true;
         }
         else if(this.FOnPracticeClick != null)
         {
            this.FOnPracticeClick(this,this.FIndex,CONST_MAGIC.TYPE_GoldPractice,1);
         }
      }
      
      protected function AdvancedPracticeOnClick(param1:MouseEvent) : void
      {
         this.FCurPracticeBtn = param1.currentTarget as MovieClip;
         if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < this.FCostGold)
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         if(this.FIsOpenAdvanced)
         {
            this.FUIWindowAdvancedPractice.IsSelected = false;
            this.FUIWindowAdvancedPractice.SetSelectedOrNot(false);
         }
         else
         {
            this.FUIWindowAdvancedPractice.IsSelected = true;
         }
         if(!this.FUIWindowAdvancedPractice.IsSelected)
         {
            this.FPracticeTimes = this.FGoldPracticeCount;
            this.FUIWindowAdvancedPractice.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Magic_Practice_All).DescribeString,this.FCostGold,this.FGoldPracticeCount);
            this.FUIWindowAdvancedPractice.SetCheckBox(true);
            this.FUIWindowAdvancedPractice.Visible = true;
         }
         else if(this.FOnPracticeClick != null)
         {
            this.FOnPracticeClick(this,this.FIndex,CONST_MAGIC.TYPE_AdvancedPractice,this.FGoldPracticeCount);
         }
      }
      
      protected function ItemPracticeOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TAppliance = null;
         var _loc3_:String = null;
         var _loc4_:TInventories = null;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:TMagic = null;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc10_:TBins = null;
         var _loc11_:TMewMagic = null;
         var _loc12_:uint = 0;
         _loc5_ = new Vector.<uint>();
         _loc4_ = new TInventories();
         var _loc13_:String = "";
         _loc6_ = this.FMagicData.Magics.GetMagicByIndex(this.FIndex);
         switch(param1.currentTarget)
         {
            case this.FBTN_ItemPractice:
               _loc12_ = 14107003;
               _loc13_ = STRING_MAGIC.STRING_ItemLess;
               break;
            case this.FBTN_ItemPracticeCopy:
               _loc12_ = 14111270;
               _loc13_ = STRING_MAGIC.STRING_ItemLessCopy;
         }
         _loc2_ = SLogicsCore.Character.Appliances.GetInventoryByTempletID(_loc12_) as TAppliance;
         if(_loc2_ == null)
         {
            FOnEffectText(this,_loc13_);
            return;
         }
         var _loc14_:int = int(SLogicsCore.Character.Appliances.GetAllCountByTempletID(_loc12_));
         _loc3_ = _loc2_.Name;
         this.FUIWindowEditor.Label = _loc3_;
         this.FUIWindowEditor.Context = _loc2_;
         this.FUIWindowEditor.Quantity = TUtilityString.Format(STRING_MAGIC.FORMAT_UsePrompt,_loc14_);
         _loc10_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MewMagic) as TBins;
         _loc9_ = uint(_loc10_.Count);
         _loc8_ = 0;
         while(_loc8_ < _loc9_)
         {
            _loc11_ = _loc10_.GetDatebaseByIndex(_loc8_) as TMewMagic;
            if(_loc11_.Type == _loc6_.Type)
            {
               if(this.FMagicData.StageID < _loc11_.NeedBlock)
               {
                  if(_loc6_.NeedReincarnationLevel == _loc11_.NeedTransLv && _loc6_.Level == _loc11_.Level)
                  {
                     FOnEffectText(this,STRING_MAGIC.STRING_PassLevel);
                     return;
                  }
                  break;
               }
               if(_loc6_.NeedExp < 0)
               {
                  FOnEffectText(this,STRING_MAGIC.STRING_LevelHighest);
                  return;
               }
            }
            _loc8_++;
         }
         _loc7_ = Math.ceil((_loc11_.ExpAll - _loc6_.ExpAll - _loc6_.CurExp) / _loc6_.ItemExp);
         if(_loc7_ >= 42949665)
         {
            _loc7_ = 1;
         }
         this.FUIWindowEditor.CanUseMax = _loc7_;
         this.FUIWindowEditor.Value = _loc14_;
         this.FUIWindowEditor.Min = 1;
         this.FUIWindowEditor.Max = _loc14_;
         this.FUIWindowEditor.SetFocus();
         this.FUIWindowEditor.Visible = true;
      }
      
      protected function GotoMoutainOnClick(param1:MouseEvent) : void
      {
         if(this.FOnEnterMoutain != null)
         {
            this.FOnEnterMoutain(this);
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         var _loc2_:uint = 0;
         if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < this.FCostGold)
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         if(this.FCurPracticeBtn == this.FMC_AdvancedPractice)
         {
            if(this.FUIWindowAdvancedPractice.IsSelected)
            {
               this.FIsOpenAdvanced = false;
            }
            _loc2_ = CONST_MAGIC.TYPE_AdvancedPractice;
         }
         else if(this.FCurPracticeBtn == this.FMC_GoldPractice)
         {
            if(this.FUIWindowAdvancedPractice.IsSelected)
            {
               this.FIsOpenGold = false;
            }
            _loc2_ = CONST_MAGIC.TYPE_GoldPractice;
         }
         if(this.FOnPracticeClick != null)
         {
            this.FOnPracticeClick(this,this.FIndex,_loc2_,this.FPracticeTimes);
         }
      }
      
      protected function WindowEditorOnOK(param1:Object) : void
      {
         var _loc2_:TAppliance = null;
         var _loc3_:int = 0;
         _loc2_ = this.FUIWindowEditor.Context as TAppliance;
         if(_loc2_.IDTemplate == 14111270)
         {
            _loc3_ = int(CONST_MAGIC.TYPE_ItemPracticeCopy);
         }
         else
         {
            _loc3_ = int(CONST_MAGIC.TYPE_ItemPractice);
         }
         if(this.FOnPracticeClick != null)
         {
            this.FOnPracticeClick(this,this.FIndex,_loc3_,this.FUIWindowEditor.Value);
         }
      }
      
      protected function WindowEditorOnCancel(param1:Object) : void
      {
         this.FUIWindowEditor.Context = null;
      }
      
      protected function WindowEditorOnMax(param1:Object) : void
      {
         var _loc2_:TAppliance = null;
         _loc2_ = this.FUIWindowEditor.Context as TAppliance;
         var _loc3_:int = int(SLogicsCore.Character.Appliances.GetAllCountByTempletID(_loc2_.IDTemplate));
         this.FUIWindowEditor.Value = _loc3_;
         this.FUIWindowEditor.SetFocus();
      }
      
      public function get OnPracticeClick() : Function
      {
         return this.FOnPracticeClick;
      }
      
      public function set OnPracticeClick(param1:Function) : void
      {
         this.FOnPracticeClick = param1;
      }
      
      public function get OnEnterMoutain() : Function
      {
         return this.FOnEnterMoutain;
      }
      
      public function set OnEnterMoutain(param1:Function) : void
      {
         this.FOnEnterMoutain = param1;
      }
      
      public function get UIHintOnOver() : Function
      {
         return this.FUIHintOnOver;
      }
      
      public function set UIHintOnOver(param1:Function) : void
      {
         this.FUIHintOnOver = param1;
      }
      
      public function get UIHintOnOut() : Function
      {
         return this.FUIHintOnOut;
      }
      
      public function set UIHintOnOut(param1:Function) : void
      {
         this.FUIHintOnOut = param1;
      }
      
      public function Update(param1:TMagicData) : void
      {
         this.FMagicData = param1;
         this.DefaultSelect();
      }
      
      public function OnLevelUpUpdate() : void
      {
         this.UpdateAtrribute();
         this.UpdateExperience();
      }
   }
}

