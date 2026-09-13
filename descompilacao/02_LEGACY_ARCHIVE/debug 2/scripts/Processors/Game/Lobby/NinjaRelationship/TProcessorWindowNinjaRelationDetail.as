package Processors.Game.Lobby.NinjaRelationship
{
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.NinjaRelation.TNinjaGroupBuff;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NinjaRelationship;
   import Resources.Strings.STRING_NINJARELATION;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowNinjaRelationDetail extends TProcessorWindowTemplate
   {
      
      protected const WIDTH_EXPBar:uint = 340;
      
      protected var FMC_Souls:Vector.<MovieClip>;
      
      protected var FNinjaName:Vector.<TextField>;
      
      protected var FRecruitStatus:Vector.<TextField>;
      
      protected var FGetResource:Vector.<TextField>;
      
      protected var FTF_CurrentEffect:TextField;
      
      protected var FTF_AdvancedEffect:TextField;
      
      protected var FTF_FriendLevel:TextField;
      
      protected var FMC_ProgressBarExp:MovieClip;
      
      protected var FTF_Experience:TextField;
      
      protected var FMC_SpecialPromote:MovieClip;
      
      protected var FMC_BluePromote:MovieClip;
      
      protected var FMC_PurplePromote:MovieClip;
      
      protected var FMC_GoldPromote:MovieClip;
      
      protected var FMC_RedPromote:MovieClip;
      
      protected var FAddExpType:uint;
      
      protected var FMC_Head:MovieClip;
      
      protected var FMC_Front:MovieClip;
      
      protected var FMC_Middle:MovieClip;
      
      protected var FMC_Back:MovieClip;
      
      protected var FBMP_Front:Bitmap;
      
      protected var FBMP_Middle:Bitmap;
      
      protected var FBMP_Back:Bitmap;
      
      protected var FHeadBitmaps:Vector.<Bitmap>;
      
      protected var FHeadIcons:Vector.<uint>;
      
      protected var FHint:THint;
      
      protected var FFetters_BlueSoul_Open:uint;
      
      protected var FFetters_BlueSoul_Expend:uint;
      
      protected var FFetters_BlueSoul_GetExp:uint;
      
      protected var FFetters_PurpleSoul_Open:uint;
      
      protected var FFetters_PurpleSoul_Expend:uint;
      
      protected var FFetters_PurpleSoul_GetExp:uint;
      
      protected var FFetters_GoldSoul_Open:uint;
      
      protected var FFetters_GoldSoul_Expend:uint;
      
      protected var FFetters_GoldSoul_GetExp:uint;
      
      protected var FFetters_RedSoul_Open:uint;
      
      protected var FFetters_RedSoul_Expend:uint;
      
      protected var FFFetters_RedSoul_GetExp:uint;
      
      protected var FFetters_GoldCoin_Open:uint;
      
      protected var FFetters_GoldCoin_Expend:uint;
      
      protected var Fetters_GoldCoin_GetExp:uint;
      
      protected var FAddPro:uint;
      
      protected var FAddCount:uint;
      
      protected var FValues:Vector.<uint>;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FContext:Object;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FAddExpOnClick:Function;
      
      protected var FToShowExchange:Function = null;
      
      public function TProcessorWindowNinjaRelationDetail(param1:TUIComponent)
      {
         super(param1);
         this.FMC_Souls = new Vector.<MovieClip>();
         this.FNinjaName = new Vector.<TextField>();
         this.FRecruitStatus = new Vector.<TextField>();
         this.FGetResource = new Vector.<TextField>();
         this.FBMP_Front = new Bitmap();
         this.FBMP_Middle = new Bitmap();
         this.FBMP_Back = new Bitmap();
         this.FHeadBitmaps = new Vector.<Bitmap>();
         this.FHeadIcons = new Vector.<uint>();
         this.FHeadBitmaps.push(this.FBMP_Front);
         this.FHeadBitmaps.push(this.FBMP_Middle);
         this.FHeadBitmaps.push(this.FBMP_Back);
         this.FValues = new Vector.<uint>();
         this.FValues.push(this.FFetters_BlueSoul_Open);
         this.FValues.push(this.FFetters_BlueSoul_Expend);
         this.FValues.push(this.FFetters_BlueSoul_GetExp);
         this.FValues.push(this.FFetters_PurpleSoul_Open);
         this.FValues.push(this.FFetters_PurpleSoul_Expend);
         this.FValues.push(this.FFetters_PurpleSoul_GetExp);
         this.FValues.push(this.FFetters_GoldSoul_Open);
         this.FValues.push(this.FFetters_GoldSoul_Expend);
         this.FValues.push(this.FFetters_GoldSoul_GetExp);
         this.FValues.push(this.FFetters_RedSoul_Open);
         this.FValues.push(this.FFetters_RedSoul_Expend);
         this.FValues.push(this.FFFetters_RedSoul_GetExp);
         this.FValues.push(this.FFetters_GoldCoin_Open);
         this.FValues.push(this.FFetters_GoldCoin_Expend);
         this.FValues.push(this.Fetters_GoldCoin_GetExp);
         this.FHint = new THint();
         this.FAddExpType = 0;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance("MC_NinjaRelationDetail") as Sprite;
         TGameUtil.AddWindowMask(this);
         UIDispatch();
         _loc2_ = CONST_NinjaRelationship.CAPACITY_SOULS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = FMainUI["MC_Soul_" + _loc1_];
            this.FMC_Souls[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc2_ = CONST_NinjaRelationship.CAPACITY_NinjaCount;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FNinjaName[_loc1_] = FMainUI["TF_Name_" + _loc1_];
            this.FRecruitStatus[_loc1_] = FMainUI["TF_RecruitStatus_" + _loc1_];
            this.FGetResource[_loc1_] = FMainUI["TF_Resource_" + _loc1_];
            _loc1_++;
         }
         this.FTF_CurrentEffect = FMainUI["TF_CurrentEffect"];
         this.FTF_AdvancedEffect = FMainUI["TF_AdvancedEffect"];
         this.FTF_FriendLevel = FMainUI["TF_FriendLevel"];
         this.FMC_ProgressBarExp = FMainUI["MC_ExpBar"]["MC_ProgressBarExp"];
         this.FTF_Experience = FMainUI["MC_ExpBar"]["TF_Experience"];
         this.FMC_SpecialPromote = FMainUI["MC_SpecialPromote"];
         this.FMC_BluePromote = FMainUI["MC_BluePromote"];
         this.FMC_PurplePromote = FMainUI["MC_PurplePromote"];
         this.FMC_GoldPromote = FMainUI["MC_GoldPromote"];
         this.FMC_RedPromote = FMainUI["MC_RedPromote"];
         TGameUtil.setButtonMode(this.FMC_SpecialPromote,true);
         TGameUtil.setButtonMode(this.FMC_BluePromote,true);
         TGameUtil.setButtonMode(this.FMC_PurplePromote,true);
         TGameUtil.setButtonMode(this.FMC_GoldPromote,true);
         TGameUtil.setButtonMode(this.FMC_RedPromote,true);
         this.FMC_Head = FMainUI["MC_Head"];
         this.FMC_Front = this.FMC_Head["MC_Front"];
         this.FMC_Middle = this.FMC_Head["MC_Middle"];
         this.FMC_Back = this.FMC_Head["MC_Back"];
         this.FMC_Front.addChild(this.FBMP_Front);
         this.FMC_Middle.addChild(this.FBMP_Middle);
         this.FMC_Back.addChild(this.FBMP_Back);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         this.Reset();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_SpecialPromote.addEventListener(MouseEvent.CLICK,this.MCFriendLevelOnClick,false,0,true);
         this.FMC_BluePromote.addEventListener(MouseEvent.CLICK,this.MCFriendLevelOnClick,false,0,true);
         this.FMC_PurplePromote.addEventListener(MouseEvent.CLICK,this.MCFriendLevelOnClick,false,0,true);
         this.FMC_GoldPromote.addEventListener(MouseEvent.CLICK,this.MCFriendLevelOnClick,false,0,true);
         this.FMC_RedPromote.addEventListener(MouseEvent.CLICK,this.MCFriendLevelOnClick,false,0,true);
         this.FMC_SpecialPromote.addEventListener(MouseEvent.MOUSE_MOVE,this.MCFriendLevelOnOver,false,0,true);
         this.FMC_BluePromote.addEventListener(MouseEvent.MOUSE_MOVE,this.MCFriendLevelOnOver,false,0,true);
         this.FMC_PurplePromote.addEventListener(MouseEvent.MOUSE_MOVE,this.MCFriendLevelOnOver,false,0,true);
         this.FMC_GoldPromote.addEventListener(MouseEvent.MOUSE_MOVE,this.MCFriendLevelOnOver,false,0,true);
         this.FMC_RedPromote.addEventListener(MouseEvent.MOUSE_MOVE,this.MCFriendLevelOnOver,false,0,true);
         this.FMC_SpecialPromote.addEventListener(MouseEvent.ROLL_OUT,this.MCFriendLevelOnOut,false,0,true);
         this.FMC_BluePromote.addEventListener(MouseEvent.ROLL_OUT,this.MCFriendLevelOnOut,false,0,true);
         this.FMC_PurplePromote.addEventListener(MouseEvent.ROLL_OUT,this.MCFriendLevelOnOut,false,0,true);
         this.FMC_GoldPromote.addEventListener(MouseEvent.ROLL_OUT,this.MCFriendLevelOnOut,false,0,true);
         this.FMC_RedPromote.addEventListener(MouseEvent.ROLL_OUT,this.MCFriendLevelOnOut,false,0,true);
         super.UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TBins = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TConfigValue = null;
         var _loc5_:int = 0;
         _loc1_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue) as TBins;
         _loc5_ = 0;
         _loc3_ = uint(_loc1_.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc1_.GetDatebaseByIndex(_loc2_) as TConfigValue;
            if(_loc4_.Identifier >= CONST_CONFIGVALUE.Fetters_BlueSoul_Open && _loc4_.Identifier <= CONST_CONFIGVALUE.Fetters_GoldCoin_GetExp)
            {
               this.FValues[_loc5_] = _loc4_.Value as uint;
               _loc5_++;
            }
            _loc2_++;
         }
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TNinjaGroupBuff = null;
         if(!Visible)
         {
            return;
         }
         if(this.FContext != null)
         {
            _loc3_ = this.FContext as TNinjaGroupBuff;
            _loc2_ = uint(_loc3_.Heros.Count);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               TGameUtil.ShowImageByID(TGameUtil.Type_FettersBig,this.FHeadBitmaps[_loc1_],CONST_MODULES.MODULE_NinjaRelation,this.FHeadIcons[_loc1_]);
               _loc1_++;
            }
         }
         super.LogicsPerform();
      }
      
      protected function UpdateHead() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TNinjaGroupBuff = null;
         var _loc4_:THero = null;
         _loc2_ = this.FHeadBitmaps.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FHeadBitmaps[_loc1_].bitmapData = null;
            _loc1_++;
         }
         _loc2_ = this.FHeadIcons.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FHeadIcons.pop();
            _loc1_++;
         }
         this.FHeadIcons.length = 0;
         _loc3_ = this.FContext as TNinjaGroupBuff;
         _loc2_ = uint(_loc3_.Heros.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.Heros.GetHeroByIndex(_loc1_);
            this.FHeadBitmaps[_loc1_].filters = _loc4_.RecruitStatus ? [] : [TGameUtil.GaryColorFilters];
            this.FHeadIcons[_loc1_] = _loc4_.Identifier;
            _loc1_++;
         }
      }
      
      protected function UpdateReruitInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TextField = null;
         var _loc4_:TNinjaGroupBuff = null;
         var _loc5_:THero = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         if(this.FContext == null)
         {
            return;
         }
         _loc4_ = this.FContext as TNinjaGroupBuff;
         _loc2_ = uint(_loc4_.Heros.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = _loc4_.Heros.GetHeroByIndex(_loc1_);
            _loc3_ = this.FNinjaName[_loc1_];
            _loc3_.text = _loc5_.Name;
            _loc3_.textColor = CONST_NinjaRelationship.COLOR_RECRUIT[uint(_loc5_.RecruitStatus)];
            _loc3_ = this.FRecruitStatus[_loc1_];
            _loc3_.text = STRING_NINJARELATION.STRING_RECRUITSTATUS[uint(_loc5_.RecruitStatus)];
            _loc3_.textColor = CONST_NinjaRelationship.COLOR_RECRUIT[uint(_loc5_.RecruitStatus)];
            _loc3_ = this.FGetResource[_loc1_];
            _loc3_.text = _loc5_.Reousrce;
            _loc1_++;
         }
         _loc2_ = CONST_NinjaRelationship.CAPACITY_SOULS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMC_Souls[_loc1_]["MC_Soul"].gotoAndStop(_loc1_ + 1);
            _loc1_++;
         }
         this.FMC_Souls[0]["TF_Count"].text = SLogicsCore.Character.HeroSoulBlueSoul.toString();
         this.FMC_Souls[1]["TF_Count"].text = SLogicsCore.Character.HeroSoulPurpleSoul.toString();
         this.FMC_Souls[2]["TF_Count"].text = SLogicsCore.Character.HeroSoulGoldSoul.toString();
         this.FMC_Souls[3]["TF_Count"].text = SLogicsCore.Character.HeroSoulOrangeSoul.toString();
         if(_loc4_.IsActivited)
         {
            _loc6_ = _loc4_.CurrentBuffDesc.split("_");
            if(_loc4_.IsMistery)
            {
               _loc7_ = _loc6_[0] + _loc6_[1];
            }
            else if(_loc4_.ShenMiIsActivited)
            {
               _loc7_ = _loc6_[0] + _loc6_[1] + "(+" + Math.floor(_loc6_[1] * _loc6_[2]) + ")" + _loc6_[3];
            }
            else
            {
               _loc7_ = _loc6_[0] + _loc6_[1] + _loc6_[3];
            }
            this.FTF_CurrentEffect.text = _loc7_;
            if(_loc4_.AdvancedBuffDesc != "")
            {
               _loc6_ = _loc4_.AdvancedBuffDesc.split("_");
               if(_loc4_.IsMistery)
               {
                  _loc7_ = _loc6_[0] + _loc6_[1];
               }
               else if(_loc4_.ShenMiIsActivited)
               {
                  _loc7_ = _loc6_[0] + _loc6_[1] + "(+" + Math.floor(_loc6_[1] * _loc6_[2]) + ")" + _loc6_[3];
               }
               else
               {
                  _loc7_ = _loc6_[0] + _loc6_[1] + _loc6_[3];
               }
               this.FTF_AdvancedEffect.text = _loc7_;
            }
         }
      }
      
      protected function UpdateExpBar() : void
      {
         var _loc1_:TNinjaGroupBuff = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(this.FContext == null)
         {
            return;
         }
         _loc1_ = this.FContext as TNinjaGroupBuff;
         _loc2_ = _loc1_.CurExpricence - _loc1_.CurStartExpricence;
         _loc3_ = _loc1_.NextExpricence - _loc1_.CurStartExpricence;
         if(_loc1_.NextExpricence == _loc1_.CurStartExpricence)
         {
            _loc2_ = _loc1_.CurStartExpricence;
            _loc3_ = _loc1_.NextExpricence;
         }
         this.FTF_FriendLevel.text = _loc1_.FriendLevel.toString();
         this.FTF_Experience.text = TUtilityString.Format(STRING_NINJARELATION.FORMAT_EXPBAR,_loc2_,_loc3_);
         if(_loc1_.NextExpricence == _loc1_.CurStartExpricence)
         {
            this.FMC_ProgressBarExp.width = this.WIDTH_EXPBar;
         }
         else
         {
            this.FMC_ProgressBarExp.width = this.WIDTH_EXPBar * _loc2_ / _loc3_;
         }
      }
      
      protected function UdpateButton() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:TNinjaGroupBuff = null;
         if(this.FContext == null)
         {
            return;
         }
         _loc2_ = this.FContext as TNinjaGroupBuff;
         this.FMC_BluePromote.visible = SLogicsCore.Character.GetMainLevel() >= this.FValues[(CONST_NinjaRelationship.TYPE_BLUESOUL - 1) * 3];
         this.FMC_PurplePromote.visible = SLogicsCore.Character.GetMainLevel() >= this.FValues[(CONST_NinjaRelationship.TYPE_PURPLESOUL - 1) * 3];
         this.FMC_GoldPromote.visible = SLogicsCore.Character.GetMainLevel() >= this.FValues[(CONST_NinjaRelationship.TYPE_GOLDSOUL - 1) * 3];
         this.FMC_SpecialPromote.visible = SLogicsCore.Character.GetMainLevel() >= this.FValues[(CONST_NinjaRelationship.TYPE_GOLDCOIN - 1) * 3];
         this.FMC_RedPromote.visible = SLogicsCore.Character.GetMainLevel() >= this.FValues[(CONST_NinjaRelationship.TYPE_GOLDCOIN - 1) * 3];
         _loc1_ = this.CheckIsActivited();
         this.SetButtonStatus(this.FMC_BluePromote,_loc1_,_loc2_.IsMistery);
         this.SetButtonStatus(this.FMC_PurplePromote,_loc1_,_loc2_.IsMistery);
         this.SetButtonStatus(this.FMC_GoldPromote,_loc1_,_loc2_.IsMistery);
         this.SetButtonStatus(this.FMC_SpecialPromote,_loc1_,_loc2_.IsMistery);
         this.SetButtonStatus(this.FMC_RedPromote,_loc1_,_loc2_.IsMistery);
      }
      
      protected function SetButtonStatus(param1:MovieClip, param2:Boolean, param3:Boolean) : void
      {
         TGameUtil.setButtonMode(param1,param2);
         param1.visible = !param3;
      }
      
      protected function CheckIsActivited() : Boolean
      {
         var _loc1_:TNinjaGroupBuff = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:THero = null;
         var _loc5_:uint = 0;
         if(this.FContext == null)
         {
            return false;
         }
         _loc1_ = this.FContext as TNinjaGroupBuff;
         _loc5_ = 0;
         _loc3_ = uint(_loc1_.Heros.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc1_.Heros.GetHeroByIndex(_loc2_);
            if(_loc4_.RecruitStatus)
            {
               _loc5_++;
            }
            _loc2_++;
         }
         if(_loc5_ == _loc3_)
         {
            return true;
         }
         return false;
      }
      
      protected function UpdateUI() : void
      {
         this.UpdateHead();
         this.UpdateReruitInfo();
         this.UpdateExpBar();
         this.UdpateButton();
      }
      
      protected function MCFriendLevelOnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         _loc2_ = param1.currentTarget.name;
         _loc4_ = this.CheckIsActivited();
         if(!_loc4_)
         {
            return;
         }
         switch(_loc2_)
         {
            case "MC_SpecialPromote":
               _loc3_ = CONST_NinjaRelationship.TYPE_GOLDCOIN;
               break;
            case "MC_BluePromote":
               _loc3_ = CONST_NinjaRelationship.TYPE_BLUESOUL;
               break;
            case "MC_PurplePromote":
               _loc3_ = CONST_NinjaRelationship.TYPE_PURPLESOUL;
               break;
            case "MC_GoldPromote":
               _loc3_ = CONST_NinjaRelationship.TYPE_GOLDSOUL;
               break;
            case "MC_RedPromote":
               _loc3_ = CONST_NinjaRelationship.TYPE_REDSOUL;
         }
         if(this.FToShowExchange != null)
         {
            this.FToShowExchange(_loc3_,this.FValues,this.FContext);
         }
      }
      
      public function ExchangeBackFun(param1:int, param2:uint, param3:uint) : void
      {
         var _loc4_:String = null;
         this.FAddExpType = param1;
         this.FAddPro = param3;
         this.FAddCount = param2;
         if(!this.FUIWindowConfirmation.IsSelected)
         {
            this.FUIWindowConfirmation.Visible = true;
            _loc4_ = TUtilityString.Format(STRING_NINJARELATION.FORMAT_GetFriendValue,this.FValues[(this.FAddExpType - 1) * 3 + 1] * param2,STRING_NINJARELATION.STRING_SOULS[this.FAddExpType - 1],this.FValues[(this.FAddExpType - 1) * 3 + 2] * param2);
            this.FUIWindowConfirmation.Text = _loc4_;
            return;
         }
         if(this.FAddExpOnClick != null)
         {
            this.FAddExpOnClick(this,this.FContext,this.FAddExpType,this.FAddCount,this.FAddPro);
         }
      }
      
      protected function MCFriendLevelOnOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         _loc2_ = param1.currentTarget.name;
         switch(_loc2_)
         {
            case "MC_SpecialPromote":
               _loc3_ = CONST_NinjaRelationship.TYPE_GOLDCOIN;
               break;
            case "MC_BluePromote":
               _loc3_ = CONST_NinjaRelationship.TYPE_BLUESOUL;
               break;
            case "MC_PurplePromote":
               _loc3_ = CONST_NinjaRelationship.TYPE_PURPLESOUL;
               break;
            case "MC_GoldPromote":
               _loc3_ = CONST_NinjaRelationship.TYPE_GOLDSOUL;
               break;
            case "MC_RedPromote":
               _loc3_ = CONST_NinjaRelationship.TYPE_REDSOUL;
         }
         _loc4_ = TUtilityString.Format(STRING_NINJARELATION.FORMAT_GetFriendValue,this.FValues[(_loc3_ - 1) * 3 + 1],STRING_NINJARELATION.STRING_SOULS[_loc3_ - 1],this.FValues[(_loc3_ - 1) * 3 + 2]);
         this.FHint.Caption = _loc4_;
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function MCFriendLevelOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         if(this.FAddExpOnClick != null)
         {
            this.FAddExpOnClick(this,this.FContext,this.FAddExpType,this.FAddCount,this.FAddPro);
         }
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = param1;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function set AddExpOnClick(param1:Function) : void
      {
         this.FAddExpOnClick = param1;
      }
      
      public function set ToShowExchange(param1:Function) : void
      {
         this.FToShowExchange = param1;
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TextField = null;
         _loc2_ = CONST_NinjaRelationship.CAPACITY_NinjaCount;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FNinjaName[_loc1_];
            _loc3_.text = "";
            _loc3_ = this.FRecruitStatus[_loc1_];
            _loc3_.text = "";
            _loc3_ = this.FGetResource[_loc1_];
            _loc3_.text = "";
            _loc1_++;
         }
         this.FTF_AdvancedEffect.text = "";
         this.FTF_CurrentEffect.text = "";
         this.FTF_Experience.text = "";
         this.FTF_FriendLevel.text = "";
      }
   }
}

